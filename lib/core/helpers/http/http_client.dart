import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;

import 'package:image_picker/image_picker.dart';

class HttpClient {
  final String _baseAddress = "http://10.0.2.2:5182";

  static const defaultHeaders = {"Content-Type": "application/json"};
  static const multipartFrom = {"Content-Type": "multipart/form-data"};

  Future<U> makeRequestMultiPart<U>(
      {required String method,
      required String path,
      required BaseMultiPartRequest body,
      Map<String, String>? headers}) async {
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

    var stream = await request.send();

    if (stream.statusCode != 200) {
      throw Exception(stream.reasonPhrase);
    }

    var response = await stream.stream.bytesToString();
    return convert.jsonDecode(response);
  }

  Future<T> makeRequestJson<T, U>(
      {required String method,
      required String path,
      BaseJsonRequest? body,
      Map<String, String>? headers}) async {
    var request = http.Request(method, Uri.parse("$_baseAddress/$path"));
    request.headers.addAll(defaultHeaders);

    if (body != null) {
      request.body = convert.jsonEncode(body.toJson());
    }

    var stream = await request.send();

    if (stream.statusCode != 200) {
      throw Exception(stream.reasonPhrase);
    }

    var response = await stream.stream.bytesToString();
    return convert.jsonDecode(response);
  }
}
