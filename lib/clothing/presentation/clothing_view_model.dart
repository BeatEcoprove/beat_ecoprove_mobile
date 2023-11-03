import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item.dart';

class ClothingViewModel extends ViewModel {
  late List<CardItemTemplate> _selectedClothCards = [];
  late List<String> _selectedFilters = [];

  void changeSelection(CardItemTemplate card) {
    int index = _selectedClothCards.indexWhere((item) => item.key == card.key);

    if (index != -1) {
      _selectedClothCards.removeAt(index);
    } else {
      _selectedClothCards.add(card);
    }

    notifyListeners();
  }

  bool get haveSelectedCards => _selectedClothCards.isNotEmpty;

  void removeCard(CardItemTemplate card) {
    print(card);
  } // TODO: Complete

  void changeFilterSelection(String filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }

    print(_selectedFilters);
    notifyListeners();
  }

  bool haveThisFilter(String filter) => _selectedFilters.contains(filter);
}
