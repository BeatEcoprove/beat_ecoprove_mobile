import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RemoveClothFromBucketRequest implements BaseJsonRequest {
  final List<String> clothIds;
  final String bucketId;

  RemoveClothFromBucketRequest(
    this.clothIds,
    this.bucketId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'clothToRemove': clothIds,
    };
  }
}
