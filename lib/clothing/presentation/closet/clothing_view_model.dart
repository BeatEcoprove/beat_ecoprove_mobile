import 'package:beat_ecoprove/clothing/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class ClothingViewModel extends ViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final DeleteCardUseCase _deleteCardUseCase;

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
    } catch (e) {
      print("$e");
    }
  }

  List<CardItem> get getCloset => _cards;

  Future<List<CardItem>> fetchCloset() async {
    try {
      _cards.clear();
      _cards.addAll(await _getClosetUseCase.handle());
    } catch (e) {
      print("$e");
    }

    return _cards;
  }

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
}
