import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/register_store_request.dart';

class StoreService {
  final HttpAuthClient _httpClient;

  StoreService(this._httpClient);

  Future registerStore(RegisterStoreRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "stores",
      body: request,
      expectedCode: 200,
    );
  }
}
