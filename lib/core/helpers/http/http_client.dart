import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_internalserver_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_unauthorized_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_statuscodes.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;

import 'package:image_picker/image_picker.dart';

class HttpClient {
  final String _baseAddress = ServerConfig.backendUrl;

  static const defaultHeaders = {"Content-Type": "application/json"};
  static const multipartFrom = {"Content-Type": "multipart/form-data"};

  Future<Map<String, dynamic>> _makeRequest(
      BaseRequest request, int expectedCode) async {
    String jsonResponse;
    int statusCode;
    StreamedResponse stream;

    try {
      stream = await request.send();
    } catch (e) {
      throw HttpInternalError.empty();
    }

    statusCode = stream.statusCode;
    jsonResponse = await stream.stream.bytesToString();

    var response = convert.jsonDecode(jsonResponse) as Map<String, dynamic>;

    if (statusCode != expectedCode) {
      switch (statusCode) {
        case HttpStatusCodes.badRequest:
          throw HttpBadRequestError(response);
        case HttpStatusCodes.unAuthorized:
          throw HttpUnAuthorizedError(response);
        default:
          throw HttpInternalError(response);
      }
    }

    return response;
  }

  Future<Map<String, dynamic>> makeRequestMultiPart(
      {required String method,
      required String path,
      required BaseMultiPartRequest body,
      Map<String, String>? headers,
      int expectedCode = HttpStatusCodes.ok}) async {
    var request =
        http.MultipartRequest(method, Uri.parse("$_baseAddress/$path"));

    request.headers.addAll(multipartFrom);
    var fields = body.toMultiPart();

    fields.forEach((key, value) async {
      if (value is String) {
        request.fields[key] = value;
      } else if (value is XFile) {
        request.files.add(await http.MultipartFile.fromPath(key, value.path,
            filename: 'avatarPicture', contentType: MediaType('image', 'png')));
      }
    });

    return _makeRequest(request, expectedCode);
  }

  Future<Map<String, dynamic>> makeRequestJson<U>(
      {required String method,
      required String path,
      BaseJsonRequest? body,
      Map<String, String>? headers,
      int expectedCode = HttpStatusCodes.ok}) async {
    var request = http.Request(method, Uri.parse("$_baseAddress/$path"));
    request.headers.addAll(defaultHeaders);

    if (body != null) {
      request.body = convert.jsonEncode(body.toJson());
    }

    return _makeRequest(request, expectedCode);
  }
}
