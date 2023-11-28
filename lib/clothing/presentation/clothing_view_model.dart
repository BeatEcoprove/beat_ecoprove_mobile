import 'package:beat_ecoprove/clothing/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:flutter/material.dart';

class ClothingViewModel extends ViewModel {
  final GetClosetUseCase _getClosetUseCase;
  final AuthenticationProvider _authProvider;
  late final User _user;
  late List<int> _selectedClothCards = [];
  late List<String> _selectedFilters = [];
  late List<String> _selectedHorizontalFilters = [];

  ClothingViewModel(
    this._authProvider,
    this._getClosetUseCase,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  bool get haveSelectedCards => _selectedClothCards.isNotEmpty;

  void changeCardsSelection(List<int> cards) {
    _selectedClothCards = cards;

    notifyListeners();
  }

  bool get haveHorizontalFilters => _selectedHorizontalFilters.isNotEmpty;

  List<String> get allSelectedHorizontalFilters => _selectedHorizontalFilters;

  bool haveThisHorizontalFilter(String filter) =>
      _selectedHorizontalFilters.contains(filter);

  void changeHorizontalFiltersSelection(List<String> filters) {
    _selectedHorizontalFilters = filters;

    notifyListeners();
  }

  bool haveThisFilter(String filter) => _selectedFilters.contains(filter);

  List<String> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(List<String> filters) {
    _selectedFilters = filters;

    notifyListeners();
  }

  void removeCard(Key card) {} // TODO: Complete

  Future<List<CardItem>> getCloset() async {
    List<CardItem> closet = [];

    try {
      closet = await _getClosetUseCase.handle(
          "edf2e8af-91fa-41d5-a135-228658b8db93"); //TODO: Change Person ID
    } catch (e) {
      print("$e");
    }

    return closet;
  }
}
