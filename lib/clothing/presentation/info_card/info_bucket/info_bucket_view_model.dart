import 'package:beat_ecoprove/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoBucketViewModel extends ViewModel {
  final RemoveClothFromBucketUseCase _removeClothFromBucketUseCase;

  InfoBucketViewModel(
    this._removeClothFromBucketUseCase,
  );

  Future removeClothFromBucket(List<String> idCloth, String idBucket) async {
    try {
      await _removeClothFromBucketUseCase
          .handle(RemoveClothFromBucketRequest(idCloth, idBucket));
    } catch (e) {
      print("$e");
    }
  }
}
