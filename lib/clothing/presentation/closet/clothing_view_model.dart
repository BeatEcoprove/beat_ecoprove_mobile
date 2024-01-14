import 'package:beat_ecoprove/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class ClothingViewModel extends ViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final DeleteCardUseCase _deleteCardUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final GoRouter _navigationRouter;

  late bool isLoading = false;

  final AuthenticationProvider _authProvider;
  late final User _user;
  late final Map<String, List<String>> _selectedCards = {};
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  final List<CardItem> _cards = [];

  ClothingViewModel(
    this._authProvider,
    this._getClosetUseCase,
    this._markClothAsDailyUseUseCase,
    this._deleteCardUseCase,
    this._registerBucketUseCase,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  bool get haveSelectedCards => _selectedCards.isNotEmpty;

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
    fetchCloset();
    notifyListeners();
  }

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilters = filters;
    fetchCloset();
    notifyListeners();
  }

  Future removeCard(String id) async {
    var card = _cards.firstWhere((element) => element.id == id);
    var type = card.hasChildren ? "bucket" : "cloth";

    try {
      await _deleteCardUseCase
          .handle(DeleteCardRequest(cardId: card.id, type: type));
    } catch (e) {
      print("$e");
    }

    _navigationRouter.go("/");
  }

  List<CardItem> get getCloset => _cards;

  Future<List<CardItem>> fetchCloset() async {
    Map<String, String> param = {};

    for (var (value as Map<String, String>) in _selectedFilters.values) {
      param.addAll(value);
    }

    for (var filter in _selectedHorizontalFilters) {
      param.addAll({filter: 'category'});
    }

    try {
      _cards.clear();
      _cards.addAll(await _getClosetUseCase.handle(param));
    } catch (e) {
      print("$e");
    }

    return _cards;
  }

  //TODO: IF IS ALREADY MARK AS USE, UNMARK
  Future markClothAsDailyUse() async {
    List<String> listIds = [];

    isLoading = true;
    notifyListeners();

    for (var elem in _selectedCards.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    try {
      await _markClothAsDailyUseUseCase.handle(listIds);
    } catch (e) {
      print("$e");
    }

    isLoading = false;
    _selectedCards.clear();
    notifyListeners();
  }

  Future registerBucket() async {
    List<String> listIds = [];

    isLoading = true;
    notifyListeners();

    for (var elem in _selectedCards.entries) {
      if (elem.value.isEmpty) {
        listIds.add(elem.key);
      } else {
        listIds.addAll(elem.value);
      }
    }

    try {
      //TODO: NAME CAN'T BE THE SAME
      await _registerBucketUseCase.handle(RegisterBucketRequest(
        'Default',
        listIds,
      ));
    } catch (e) {
      print("$e");
    }

    isLoading = false;
    _selectedCards.clear();
    notifyListeners();
  }
}
