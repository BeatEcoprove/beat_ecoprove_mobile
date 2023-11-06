import 'package:beat_ecoprove/core/view_model.dart';
import 'package:flutter/material.dart';

class ClothingViewModel extends ViewModel {
  late List<int> _selectedClothCards = [];
  late List<String> _selectedFilters = [];
  late List<String> _selectedHorizontalFilters = [];

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
}
