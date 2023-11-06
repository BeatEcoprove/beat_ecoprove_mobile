import 'package:beat_ecoprove/core/domain/models/error_response.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_statuscodes.dart';

class HttpInternalError extends HttpError<ErrorResponse> {
  HttpInternalError.empty()
      : super({
          "type": "internal_error",
          "title": "Ups ocorreu um erro inesperado",
          "status": 500,
        }, HttpStatusCodes.badRequest);

  HttpInternalError(Map<String, dynamic> result)
      : super(result, HttpStatusCodes.badRequest);

  @override
  ErrorResponse getError() {
    return ErrorResponse.fromJson(result);
  }
}
