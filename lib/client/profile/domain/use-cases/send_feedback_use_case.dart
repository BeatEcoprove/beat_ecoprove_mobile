import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/send_feedback_request.dart';
import 'package:beat_ecoprove/client/profile/services/feedback_service.dart';

class SendFeedbackUseCase implements UseCase<SendFeedbackRequest, Future> {
  final FeedbackService _feedbackService;

  SendFeedbackUseCase(this._feedbackService);

  @override
  Future handle(SendFeedbackRequest request) async {
    try {
      await _feedbackService.sendFeedback(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
