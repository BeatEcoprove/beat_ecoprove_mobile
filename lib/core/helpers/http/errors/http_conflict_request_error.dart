import 'package:beat_ecoprove/core/domain/models/error_response.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_statuscodes.dart';

class HttpConflictRequestError extends HttpError<ErrorResponse> {
  HttpConflictRequestError(Map<String, dynamic> result)
      : super(result, HttpStatusCodes.conflictRequest);

  @override
  ErrorResponse getError() {
    return ErrorResponse.fromJson(result);
  }
}
