import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/home/contracts/service_provider_plus_result.dart';
import 'package:beat_ecoprove/home/contracts/service_provider_result.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_public_adverts_use_case.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_service_provider_adverts_use_case.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/advert_result.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/store_result.dart';

class ServiceProviderService {
  final HttpAuthClient _httpClient;

  ServiceProviderService(this._httpClient);

  Future<List<ServiceProviderResult>> getServicesProviders({
    int page = 1,
    int pageSize = 100,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "providers?page=$page&pageSize=$pageSize",
      expectedCode: 200,
    );

    return result
        .map((storeJson) => ServiceProviderResult.fromJson(storeJson))
        .toList();
  }

  Future<ServiceProviderPlusResult> getDetailsServiceProvider(
      String serviceProviderId) async {
    var serviceProviderJson = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "providers/$serviceProviderId",
      expectedCode: 200,
    );

    return ServiceProviderPlusResult.fromJson(serviceProviderJson);
  }

  Future<List<StoreResult>> getStoresOfServiceProvider(
    String serviceProviderId, {
    int page = 1,
    int pageSize = 100,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "providers/$serviceProviderId/stores?page=$page&pageSize=$pageSize",
      expectedCode: 200,
    );

    return result.map((storeJson) => StoreResult.fromJson(storeJson)).toList();
  }

  Future<List<AdvertResult>> getPublicAdverts(
      GetPublicAdvertsUseCaseRequest request) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "public/adverts?page=${request.page}&pageSize=${request.pageSize}",
      expectedCode: 200,
    );

    return result
        .map((advertJson) => AdvertResult.fromJson(advertJson))
        .toList();
  }

  Future<List<AdvertResult>> getServiceProviderAdverts(
      GetServiceProviderAdvertsUseCaseRequest request) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path:
          "providers/${request.serviceProviderId}/adverts?page=${request.page}&pageSize=${request.pageSize}",
      expectedCode: 200,
    );

    return result
        .map((advertJson) => AdvertResult.fromJson(advertJson))
        .toList();
  }
}
