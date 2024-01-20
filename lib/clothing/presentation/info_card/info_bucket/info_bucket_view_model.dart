import 'package:beat_ecoprove/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoBucketViewModel extends ViewModel {
  final RemoveClothFromBucketUseCase _removeClothFromBucketUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;

  InfoBucketViewModel(
    this._removeClothFromBucketUseCase,
    this._unMarkClothAsDailyUseUseCase,
  );

  Future removeClothFromBucket(List<String> idCloth, String idBucket) async {
    try {
      await _removeClothFromBucketUseCase
          .handle(RemoveClothFromBucketRequest(idCloth, idBucket));
    } catch (e) {
      print("$e");
    }
  }

  Future unMarkClothsFromBucket(List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth);
    } catch (e) {
      print("$e");
    }
  }
}
