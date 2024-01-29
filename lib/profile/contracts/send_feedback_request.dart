import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class SendFeedbackRequest implements BaseJsonRequest {
  final String title;
  final String description;

  SendFeedbackRequest(
    this.title,
    this.description,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
