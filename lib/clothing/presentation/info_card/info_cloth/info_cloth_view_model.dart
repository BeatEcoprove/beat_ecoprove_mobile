import 'package:beat_ecoprove/clothing/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoClothViewModel extends ViewModel {
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;

  InfoClothViewModel(
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
  );

  Future setClothState(List<String> idsCloth, bool isSelect) async {
    isSelect
        ? _unMarkClothAsDailyUse(idsCloth)
        : _markClothAsDailyUse(idsCloth);
  }

  Future _markClothAsDailyUse(List<String> idsCloth) async {
    try {
      await _markClothAsDailyUseUseCase.handle(idsCloth);
    } catch (e) {
      print("$e");
    }
  }

  Future _unMarkClothAsDailyUse(List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth);
    } catch (e) {
      print("$e");
    }
  }
}
