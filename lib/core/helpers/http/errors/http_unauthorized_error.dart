import 'package:beat_ecoprove/core/domain/models/error_response.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_statuscodes.dart';

class HttpUnAuthorizedError extends HttpError<ErrorResponse> {
  HttpUnAuthorizedError(Map<String, dynamic> message)
      : super(message, HttpStatusCodes.unAuthorized);

  @override
  ErrorResponse getError() => ErrorResponse.fromJson(result);
}
