import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/value_objects/bucket_name.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:go_router/go_router.dart';

class ClothingViewModel extends FormViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final DeleteCardUseCase _deleteCardUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final AddClothsBucketUseCase _addToBucketUseCase;
  final GoRouter _navigationRouter;

  final AuthenticationProvider _authProvider;
  final NotificationProvider _notificationProvider;
  late final User _user;
  late final Map<String, List<String>> _selectedCards = {};
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  final List<CardItem> _cards = [];
  final List<CardItem> _buckets = [];

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
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
    initializeFields([FormFieldValues.name]);
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

  Future<void> fetchCloset() async {
    Map<String, String> param = {};

    for (var (value as Map<String, String>) in _selectedFilters.values) {
      param.addAll(value);
    }

    for (var filter in _selectedHorizontalFilters) {
      param.addAll({filter: 'category'});
    }

    try {
      _buckets.clear();
      _cards.clear();
      _cards.addAll(await _getClosetUseCase.handle(param));

      _buckets.addAll(_cards.where(
          (element) => element.hasChildren == true && element.id != "outfit"));
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
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

    notifyListeners();

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
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Cesto criado!",
      type: NotificationTypes.success,
    );

    _selectedCards.clear();
    _navigationRouter.go('/');
    notifyListeners();
  }

  Future addToBucket(
      String bucketId, Map<String, List<String>> selectedCards) async {
    List<String> listIds = [];

    notifyListeners();

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
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Peça/s adicionada/s ao cesto com sucesso!",
      type: NotificationTypes.success,
    );

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
}
