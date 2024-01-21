import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class AddClothsBucketRequest implements BaseJsonRequest {
  final String bucketId;
  final List<String> bucketIdsItems;

  AddClothsBucketRequest(
    this.bucketId,
    this.bucketIdsItems,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'clothToAdd': bucketIdsItems,
    };
  }
}
