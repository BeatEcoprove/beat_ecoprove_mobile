import 'package:beat_ecoprove/core/contracts/image_request.dart';
import 'package:beat_ecoprove/core/contracts/image_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class UploadImageService {
  final HttpAuthClient _httpClient;

  UploadImageService(this._httpClient);

  Future<ImageResult> upload(ImageRequest request) async {
    var response = await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "core/upload",
      body: request,
      expectedCode: 201,
    );

    return ImageResult.fromJson(response);
  }
}
