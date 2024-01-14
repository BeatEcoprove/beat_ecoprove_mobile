import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RegisterBucketRequest implements BaseJsonRequest {
  final String bucketName;
  final List<String> bucketIdsItems;

  RegisterBucketRequest(
    this.bucketName,
    this.bucketIdsItems,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': bucketName,
      'clothIds': bucketIdsItems,
    };
  }
}
