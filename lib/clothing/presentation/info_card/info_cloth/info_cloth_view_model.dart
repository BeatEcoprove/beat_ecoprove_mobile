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

  Future setClothState(String idCloth, bool isSelect) async {
    isSelect ? _unMarkClothAsDailyUse(idCloth) : _markClothAsDailyUse(idCloth);
  }

  Future _markClothAsDailyUse(String idCloth) async {
    try {
      await _markClothAsDailyUseUseCase.handle(idCloth);
    } catch (e) {
      print("$e");
    }
  }

  Future _unMarkClothAsDailyUse(String idCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idCloth);
    } catch (e) {
      print("$e");
    }
  }
}
