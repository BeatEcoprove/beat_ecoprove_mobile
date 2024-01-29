import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/profile/contracts/send_feedback_request.dart';

class FeedbackService {
  final HttpAuthClient _httpClient;

  FeedbackService(this._httpClient);

  Future<void> sendFeedback(SendFeedbackRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path: "extensions/feedback",
      body: request,
      expectedCode: 200,
    );
  }
}
