import 'package:beat_ecoprove/clothing/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class ClothingViewModel extends ViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final AuthenticationProvider _authProvider;
  late final User _user;
  late List<String> _selectedClothCards = [];
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  final List<CardItem> _cards = [];

  ClothingViewModel(
    this._authProvider,
    this._getClosetUseCase,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  bool get haveSelectedCards => _selectedClothCards.isNotEmpty;

  void changeCardsSelection(List<String> cards) {
    _selectedClothCards = cards;
  }

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
  }

  void removeCard(String id) {} // TODO: Complete

  List<CardItem> get getCloset => _cards;

  Future fetchCloset() async {
    try {
      _cards.clear();
      _cards.addAll(await _getClosetUseCase.handle());
    } catch (e) {
      print("$e");
    }
  }
}
