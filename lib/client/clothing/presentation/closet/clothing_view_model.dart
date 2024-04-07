import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/data/filters.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class ClotingViewModel extends FormViewModel implements Clone {
  final AuthenticationProvider _authenticationProvider;
  final GetClosetUseCase _closetUseCase;
  final NotificationProvider _notificationProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final StaticValuesProvider _valuesProvider;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final DeleteCardUseCase _deleteCardUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final AddClothsBucketUseCase _addClothsBucketUseCase;
  final INavigationManager _navigationManager;

  late List<FilterRow> _getColors = [];
  late List<FilterRow> _getBrands = [];
  late List<FilterRow> _getNestedProfiles = [];

  late User user;
  final List<CardItem> cloths = [];
  final List<String> horizontalSelectedTags = [];
  final Map<String, List<String>> selectedCloth = {};
  final Map<String, dynamic> filterSelection = {};

  ClotingViewModel(
    this._authenticationProvider,
    this._closetUseCase,
    this._notificationProvider,
    this._getNestedProfilesUseCase,
    this._valuesProvider,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._navigationManager,
    this._deleteCardUseCase,
    this._registerBucketUseCase,
    this._addClothsBucketUseCase,
  ) {
    initializeFields([
      FormFieldValues.search,
      FormFieldValues.name,
    ]);

    user = _authenticationProvider.appUser;

    getAllColors();
    getAllBrands();
    getAllNestedProfiles();
  }

  get getBuckets => cloths
      .where((card) => card.hasChildren && card.title != 'Outfit')
      .toList();

  @override
  void initSync() async {
    await fetchCloths();
  }

  Future<void> refetch() async {
    selectedCloth.clear();
    notifyListeners();

    await fetchCloths();
  }

  Future fetchCloths() async {
    Map<String, String> param = {};

    try {
      for (var (value as Map<String, String>) in filterSelection.values) {
        param.addAll(value);
      }

      for (var filter in horizontalSelectedTags) {
        param.addAll({filter: 'category'});
      }

      param.addAll({getValue(FormFieldValues.search).value ?? "": "search"});

      var result = await _closetUseCase.handle(param);

      cloths.clear();
      cloths.addAll(result);
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    notifyListeners();
  }

  bool get haveBucketInSelected =>
      selectedCloth.values.every(
        (cards) => cards.isEmpty,
      ) &&
      !selectedCloth.keys.any((element) => element == "outfit");

  bool haveThisFilter(String filter) => filterSelection.containsKey(filter);

  void changeFilterSelection(Map<String, dynamic> filters) async {
    filterSelection.clear();
    filterSelection.addAll(filters);

    await fetchCloths();
  }

  List<FilterRow> getFilters() {
    return optionsToFilter.map((filter) => filter.toFilterRow()).toList() +
        _getColors +
        _getBrands +
        _getNestedProfiles;
  }

  void selectHorizontalTag(List<String> tags) async {
    horizontalSelectedTags.clear();
    horizontalSelectedTags.addAll(tags);

    await fetchCloths();
  }

  void changeCardsSelection(Map<String, List<String>> cards) {
    if (selectedCloth.containsKey(cards.keys.first)) {
      selectedCloth.remove(cards.keys.first);
    } else {
      selectedCloth.addAll(cards);
    }

    notifyListeners();
  }

  void setSearch(String search) async {
    try {
      setValue<String>(FormFieldValues.search, search);

      await fetchCloths();
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  void setName(String name) async {
    try {
      setValue<String>(FormFieldValues.name, name);

      await fetchCloths();
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  Future setStateFromCloth() async {
    List<String> listIdsInUse = [];
    List<String> listIdsIdle = [];
    List<String> selectedElements = [];

    void addToLists(CardItem card) {
      switch (card.clothState!) {
        case ClothStates.inUse:
          if (!listIdsInUse.contains(card.id)) {
            listIdsInUse.add(card.id);
          }
          break;
        case ClothStates.idle:
          if (!listIdsIdle.contains(card.id)) {
            listIdsIdle.add(card.id);
          }
          break;
        case ClothStates.blocked:
          break;
      }
    }

    for (var e in cloths) {
      if (e.clothState == null) {
        var cards = e.child as List<CardItem>;

        for (var card in cards) {
          addToLists(card);
        }
      }

      if (e.clothState != null) {
        addToLists(e);
      }
    }

    for (var elem in selectedCloth.entries) {
      if (elem.value.isEmpty) {
        selectedElements.add(elem.key);
      } else {
        selectedElements.addAll(elem.value);
      }
    }

    var listToMark = listIdsIdle
        .where((elemento) => selectedElements.contains(elemento))
        .toList();

    if (listToMark.isNotEmpty) {
      try {
        await _markClothAsDailyUseUseCase.handle(listToMark);
        _notificationProvider.showNotification(
          "Estado/s atualizado/s!",
          type: NotificationTypes.success,
        );
      } on HttpBadRequestError catch (e) {
        _notificationProvider.showNotification(
          e.getError().title,
          type: NotificationTypes.error,
        );
      } catch (e) {
        print("$e");
        _notificationProvider.showNotification(
          e.toString(),
          type: NotificationTypes.error,
        );
      }
    }

    var listToUnMark = listIdsInUse
        .where((elemento) => selectedElements.contains(elemento))
        .toList();

    try {
      await _unMarkClothAsDailyUseUseCase.handle(listToUnMark);

      _notificationProvider.showNotification(
        "Estado/s atualizado/s!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    refetch();
  }

  Future removeCloth(String id) async {
    var card = cloths.firstWhere((element) => element.id == id);
    var type = card.hasChildren ? "bucket" : "cloth";

    try {
      await _deleteCardUseCase.handle(
        DeleteCardRequest(cardId: card.id, type: type),
      );

      cloths.removeWhere((card) {
        if (card.id == id) {
          return true;
        }

        return false;
      });

      _notificationProvider.showNotification(
        "Removido com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }

  bool isBucketItem(CardItem card) => card.hasChildren;

  Future openInfoCard(CardItem card) async {
    AppRoute routePath;

    if (isBucketItem(card)) {
      routePath = ClothingRoutes.setBucketDetails(card.id);
    } else {
      routePath = ClothingRoutes.setClothDetails(card.id);
    }

    await _navigationManager.pushAsync(
      routePath,
      extras: card,
    );
  }

  Future<List<FilterRow>> getAllColors() async {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = _valuesProvider.colors;
    } catch (e) {
      print("$e");
    }

    for (var color in colors) {
      colorItems.add(FilterButtonItem(
        text: color.name,
        value: color.hex,
        backgroundColor: Color(
          int.parse(
            color.hex,
            radix: 16,
          ),
        ),
        dimension: 30,
        tag: "color",
      ));
    }

    _getColors = [
      FilterRow(
        title: 'Cor',
        options: colorItems,
        isCircular: true,
      )
    ];

    return [
      FilterRow(options: colorItems, isCircular: true),
    ];
  }

  Future<List<FilterRow>> getAllBrands() async {
    List<BrandItem> brands = [];
    List<FilterButtonItem> brandItems = [];

    try {
      brands = _valuesProvider.brands;
    } catch (e) {
      print("$e");
    }

    for (var brand in brands) {
      brandItems.add(FilterButtonItem(
        text: brand.name,
        dimension: 60,
        content: PresentImage(
            fit: BoxFit.scaleDown, path: ServerImage(brand.brandAvatar)),
        value: brand.name,
        tag: "brand",
      ));
    }

    _getBrands = [
      FilterRow(
        title: 'Marca',
        options: brandItems,
      )
    ];
    return [FilterRow(title: 'Marca', options: brandItems)];
  }

  Future<List<FilterRow>> getAllNestedProfiles() async {
    List<ProfileResult> nestedProfiles = [];
    List<FilterButtonItem> profileItem = [];

    try {
      var profiles = await _getNestedProfilesUseCase.handle();
      nestedProfiles = profiles.nestedProfiles;

      if (user.name == profiles.mainProfile.username) {
        for (var profile in nestedProfiles) {
          profileItem.add(FilterButtonItem(
            text: profile.username,
            content: PresentImage(
              path: ServerImage(profile.avatarUrl),
            ),
            value: profile.id,
            tag: "profileId",
          ));
        }

        _getNestedProfiles = [
          FilterRow(
            title: 'Perfis',
            options: profileItem,
          )
        ];
      }
    } catch (e) {
      print("$e");
    }

    return [FilterRow(title: 'Perfis', options: profileItem)];
  }

  Future registerBucket(Map<String, List<String>> selectedCloth) async {
    List<String> listIds = [];

    for (var elem in selectedCloth.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _registerBucketUseCase.handle(
        RegisterBucketRequest(
          name,
          listIds,
        ),
      );

      _notificationProvider.showNotification(
        "Cesto criado!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _navigationManager.pop();

    setValue(FormFieldValues.name, "");
    await refetch();
  }

  void createBucket(List<ServiceTemplate> items) {
    _navigationManager.push(
      CoreRoutes.selectService,
      extras: ServiceParams(
        services: {
          "Em que cesto pretende inserir esta peça?": items,
        },
      ),
    );
  }

  Future addToBucket(
    String bucketId,
    Map<String, List<String>> selectedCloth,
  ) async {
    List<String> listIds = [];

    for (var elem in selectedCloth.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    try {
      await _addClothsBucketUseCase.handle(
        AddClothsBucketRequest(
          bucketId,
          listIds,
        ),
      );

      _notificationProvider.showNotification(
        "Peça/s adicionada/s ao cesto com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _navigationManager.pop();

    refetch();
  }

  @override
  clone() {
    return ClotingViewModel(
      _authenticationProvider,
      _closetUseCase,
      _notificationProvider,
      _getNestedProfilesUseCase,
      _valuesProvider,
      _markClothAsDailyUseUseCase,
      _unMarkClothAsDailyUseUseCase,
      _navigationManager,
      _deleteCardUseCase,
      _registerBucketUseCase,
      _addClothsBucketUseCase,
    );
  }
}
