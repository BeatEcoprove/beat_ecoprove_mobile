import 'package:beat_ecoprove/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoBucketViewModel extends ViewModel {
  final RemoveClothFromBucketUseCase _removeClothFromBucketUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;

  late final Map<String, List<String>> _selectedCards = {};
  late final List<String> _selectedClothCards = [];

  InfoBucketViewModel(
    this._removeClothFromBucketUseCase,
    this._unMarkClothAsDailyUseUseCase,
  );

  void changeCardsSelection(Map<String, List<String>> cards) {
    if (_selectedCards.containsKey(cards.keys.first)) {
      _selectedCards.remove(cards.keys.first);
      _selectedClothCards.remove(cards.keys.first);
    } else {
      _selectedCards.addAll(cards);
      _selectedClothCards.add(cards.keys.first);
    }

    notifyListeners();
  }

  Map<String, List<String>> get selectedCards => _selectedCards;

  Future removeClothFromBucket(List<String> idCloth, String idBucket) async {
    try {
      await _removeClothFromBucketUseCase.handle(RemoveClothFromBucketRequest(
          idCloth
              .where((element) => !_selectedClothCards.contains(element))
              .toList(),
          idBucket));
    } catch (e) {
      print("$e");
    }
  }

  Future unMarkClothsFromBucket(List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth
          .where((element) => !_selectedClothCards.contains(element))
          .toList());
    } catch (e) {
      print("$e");
    }
  }
}
