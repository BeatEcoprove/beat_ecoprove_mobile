import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ChangeBucketNameRequest implements BaseJsonRequest {
  final String bucketName;
  final String bucketId;

  ChangeBucketNameRequest(
    this.bucketName,
    this.bucketId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': bucketName,
    };
  }
}
