import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class ClothingViewModel extends ViewModel {
  late List<ClothItem> _selectedClothCards = [];

  changeSelection(ClothItem card) {
    if (_selectedClothCards.contains(card)) {
      _selectedClothCards.remove(card);
    } else {
      _selectedClothCards.add(card);
    }
    notifyListeners();
  }

  bool get haveSelectedCards => _selectedClothCards.isNotEmpty;
}
