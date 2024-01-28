import 'dart:ui';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/data/filters.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/value_objects/bucket_name.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_colors_use_case.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClothingViewModel extends FormViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final DeleteCardUseCase _deleteCardUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final AddClothsBucketUseCase _addToBucketUseCase;
  final GetColorsUseCase _getColorsUseCase;
  final GetBrandsUseCase _getBrandsUseCase;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final GoRouter _navigationRouter;

  final AuthenticationProvider _authProvider;
  final NotificationProvider _notificationProvider;
  late final User _user;
  late final Map<String, List<String>> _selectedCards = {};
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  final List<CardItem> _cards = [];
  final List<CardItem> _buckets = [];
  late List<FilterRow> _getColors = [];
  late List<FilterRow> _getBrands = [];
  late List<FilterRow> _getNestedProfiles = [];

  late bool shouldUpdateData = true;

  ClothingViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getClosetUseCase,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._deleteCardUseCase,
    this._registerBucketUseCase,
    this._addToBucketUseCase,
    this._getColorsUseCase,
    this._getBrandsUseCase,
    this._getNestedProfilesUseCase,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.search,
    ]);
    getAllColors();
    getAllBrands();
    getAllNestedProfiles();
  }

  User get user => _user;

  void setUpdateUpdateData(bool value) {
    shouldUpdateData = value;
  }

  void setName(String name) {
    try {
      setValue<String>(
          FormFieldValues.name, BucketName.create(name).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  bool get haveSelectedCards => _selectedCards.isNotEmpty;

  bool get haveBucketInSelected => _selectedCards.values.every(
        (cards) => cards.isEmpty,
      );

  void changeCardsSelection(Map<String, List<String>> cards) {
    if (_selectedCards.containsKey(cards.keys.first)) {
      _selectedCards.remove(cards.keys.first);
    } else {
      _selectedCards.addAll(cards);
    }

    notifyListeners();
  }

  Map<String, List<String>> get selectedCards => _selectedCards;

  bool get haveHorizontalFilters => _selectedHorizontalFilters.isNotEmpty;

  List<String> get allSelectedHorizontalFilters => _selectedHorizontalFilters;

  bool haveThisHorizontalFilter(String filter) =>
      _selectedHorizontalFilters.contains(filter);

  void changeHorizontalFiltersSelection(List<String> filters) {
    _selectedHorizontalFilters = filters;
    notifyListeners();
  }

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilters = filters;
    notifyListeners();
  }

  Future removeCard(String id) async {
    var card = _cards.firstWhere((element) => element.id == id);
    var type = card.hasChildren ? "bucket" : "cloth";

    try {
      await _deleteCardUseCase
          .handle(DeleteCardRequest(cardId: card.id, type: type));

      _notificationProvider.showNotification(
        "Removido com sucesso!",
        type: NotificationTypes.success,
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

  List<CardItem> get getCloset => _cards;

  List<CardItem> get getBuckets => _buckets;

  Future<List<CardItem>> fetchCloset() async {
    List<CardItem> result = [];
    Map<String, String> param = {};

    for (var (value as Map<String, String>) in _selectedFilters.values) {
      param.addAll(value);
    }

    for (var filter in _selectedHorizontalFilters) {
      param.addAll({filter: 'category'});
    }

    param.addAll({getValue(FormFieldValues.search).value ?? "": "search"});

    try {
      _buckets.clear();
      _cards.clear();
      result = await _getClosetUseCase.handle(param);
      _cards.addAll(result);

      _buckets.addAll(_cards.where(
          (element) => element.hasChildren == true && element.id != "outfit"));
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    return result;
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

    for (var e in getCloset) {
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

    for (var elem in selectedCards.entries) {
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
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    listIdsInUse.clear();
    listIdsIdle.clear();
    selectedElements.clear();
    _selectedCards.clear();
    notifyListeners();
  }

  Future registerBucket(Map<String, List<String>> selectedCards) async {
    List<String> listIds = [];

    for (var elem in selectedCards.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _registerBucketUseCase.handle(RegisterBucketRequest(
        name,
        listIds,
      ));
      _notificationProvider.showNotification(
        "Cesto criado!",
        type: NotificationTypes.success,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _selectedCards.clear();
    _navigationRouter.go('/');
    notifyListeners();
  }

  Future addToBucket(
      String bucketId, Map<String, List<String>> selectedCards) async {
    List<String> listIds = [];

    for (var elem in selectedCards.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    try {
      await _addToBucketUseCase.handle(AddClothsBucketRequest(
        bucketId,
        listIds,
      ));
      _notificationProvider.showNotification(
        "Peça/s adicionada/s ao cesto com sucesso!",
        type: NotificationTypes.success,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _selectedCards.clear();
    _navigationRouter.go('/');
    notifyListeners();
  }

  bool isBucketItem(CardItem card) => card.hasChildren;

  Future openInfoCard(CardItem card) async {
    var path = isBucketItem(card)
        ? "/info/bucket/${card.id}"
        : "/info/cloth/${card.id}";

    await _navigationRouter.push(path, extra: card);
    notifyListeners();
  }

  List<FilterRow> get getFilters =>
      optionsToFilter.map((filter) => filter.toFilterRow()).toList() +
      _getColors +
      _getBrands +
      _getNestedProfiles;

  Future<List<FilterRow>> getAllColors() async {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = await _getColorsUseCase.handle();
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
    return [FilterRow(options: colorItems, isCircular: true)];
  }

  Future<List<FilterRow>> getAllBrands() async {
    List<BrandItem> brands = [];
    List<FilterButtonItem> brandItems = [];

    try {
      brands = await _getBrandsUseCase.handle();
    } catch (e) {
      print("$e");
    }

    //TODO: CHANGE CONTENT TO SERVER IMAGE
    for (var brand in brands) {
      brandItems.add(FilterButtonItem(
        text: brand.name,
        content: Image.asset("assets/default_avatar.png"),
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

      if (_user.name == profiles.mainProfile.username) {
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
}
