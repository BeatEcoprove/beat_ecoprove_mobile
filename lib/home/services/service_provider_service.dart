import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/home/contracts/service_provider_result.dart';

class ServiceProviderService {
  final HttpAuthClient _httpClient;

  ServiceProviderService(this._httpClient);

  Future<List<ServiceProviderResult>> getServicesProviders({
    int page = 1,
    int pageSize = 100,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "servicesproviders?page=$page&pageSize=$pageSize",
      expectedCode: 200,
    );

    return result
        .map((storeJson) => ServiceProviderResult.fromJson(storeJson))
        .toList();
  }
}
