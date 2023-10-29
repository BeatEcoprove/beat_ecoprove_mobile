import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cardItem.dart';

class ClothingViewModel extends ViewModel {
  late List<CardItemTemplate> _selectedClothCards = [];

  void changeSelection(CardItemTemplate card) {
    int index = _selectedClothCards.indexWhere((item) => item.key == card.key);

    print(card.key);
    if (index != -1) {
      _selectedClothCards.removeAt(index);
      print("Remove");
    } else {
      _selectedClothCards.add(card);
      print("Add");
    }

    print(_selectedClothCards.length);
    notifyListeners();
  }

  bool get haveSelectedCards => _selectedClothCards.isNotEmpty;
}
