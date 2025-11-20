import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_internalserver_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_unauthorized_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_statuscodes.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class HttpClient {
  final String _baseAddress = ServerConfig.backendUrl;

  static const Duration timeOutDuration = Duration(seconds: 15);
  static const defaultHeaders = {"Content-Type": "application/json"};

  Future<U> _makeRequest<U>(BaseRequest request, int expectedCode) async {
    final response = await request.send().timeout(timeOutDuration);
    return _handleResponse<U>(response, expectedCode);
  }

  Future<TResponse> _handleResponse<TResponse>(
      StreamedResponse response, int expectedCode) async {
    final statusCode = response.statusCode;
    final rawBody = await response.stream.bytesToString();
    dynamic jsonOutput;

    if (rawBody.isEmpty) {
      throw HttpInternalError.empty();
    }

    jsonOutput = convert.jsonDecode(rawBody);

    if (statusCode == expectedCode) {
      return jsonOutput as TResponse;
    }

    switch (statusCode) {
      case HttpStatusCodes.badRequest:
        throw HttpBadRequestError(jsonOutput);
      case HttpStatusCodes.conflictRequest:
        throw HttpConflictRequestError(jsonOutput);
      case HttpStatusCodes.unAuthorized:
        throw HttpUnAuthorizedError(jsonOutput);
      default:
        throw HttpInternalError(jsonOutput);
    }
  }

  Future<U> makeRequestMultiPart<U>({
    required String method,
    required String path,
    required BaseMultiPartRequest body,
    Map<String, String>? headers,
    int expectedCode = HttpStatusCodes.ok,
  }) async {
    final request =
        http.MultipartRequest(method, Uri.parse("$_baseAddress/$path"));

    request.headers.addAll({
      "Accept-Language": LocaleContext.getCurrentLocaleString(),
    });

    if (headers != null) request.headers.addAll(headers);

    final fields = body.toMultiPart();

    for (var entry in fields.entries) {
      if (entry.value is String) {
        request.fields[entry.key] = entry.value as String;
      }

      if (entry.value is XFile && entry.value.name != "default_avatar.png") {
        final xfile = entry.value as XFile;
        final mimeType = lookupMimeType(xfile.name) ?? 'image/jpeg';

        final file = await http.MultipartFile.fromPath(
          entry.key,
          xfile.path,
          filename: xfile.name,
          contentType: MediaType.parse(mimeType),
        );

        request.files.add(file);
      }
    }

    return _makeRequest(request, expectedCode);
  }

  Future<U> makeRequestJson<U>({
    required String method,
    required String path,
    BaseJsonRequest? body,
    Map<String, String>? headers,
    int expectedCode = HttpStatusCodes.ok,
  }) async {
    var request = http.Request(method, Uri.parse("$_baseAddress/$path"));

    if (headers != null) {
      request.headers.addAll(headers);
    }

    request.headers.addAll(defaultHeaders);

    if (body != null) {
      request.body = convert.jsonEncode(body.toJson());
    }

    return _makeRequest(request, expectedCode);
  }

  Future<U> makeRequestFormUrlEncoded<U>({
    required String method,
    required String path,
    required BaseFormUrlEncodedRequest body,
    Map<String, String>? headers,
    int expectedCode = HttpStatusCodes.ok,
  }) async {
    var request = http.Request(method, Uri.parse("$_baseAddress/$path"));

    if (headers != null) {
      request.headers.addAll(headers);
    }

    request.headers.addAll({
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept-Language": LocaleContext.getCurrentLocaleString(),
    });

    request.bodyFields = body.toFormUrlEncoded();

    return _makeRequest(request, expectedCode);
  }
}
