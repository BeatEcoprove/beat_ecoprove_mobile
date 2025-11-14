import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class SendFeedbackRequest implements BaseJsonRequest {
  final String profileId;
  final String title;
  final String description;

  SendFeedbackRequest(
    this.profileId,
    this.title,
    this.description,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'title': title,
      'description': description,
    };
  }
}
