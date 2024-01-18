import 'package:beat_ecoprove/clothing/contracts/finish_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/contracts/get_current_maintenance_action_request.dart';
import 'package:beat_ecoprove/clothing/contracts/make_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/contracts/service_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class ActionService {
  final HttpAuthClient _httpClient;

  ActionService(this._httpClient);

  Future<ServiceResult> getAllServices(String filters) async {
    return ServiceResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "services",
      expectedCode: 200,
    ));
  }

  Future<List<ServiceResult>> getClothAvailableServices(String clothId) async {
    var result = await _httpClient.makeRequestJson<List<dynamic>>(
      method: HttpMethods.get,
      path: "profiles/closet/cloth/$clothId/services",
      expectedCode: 200,
    );

    return result.map((e) => ServiceResult.fromJson(e)).toList();
  }

  Future makeMaintenanceOnCloth(MakeMaintenanceOnClothRequest request) async {
    return await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path:
          "profiles/closet/cloth/${request.clothId}/services/${request.serviceId}/perform/${request.actionId}",
      expectedCode: 200,
    );
  }

  Future finishMaintenanceOnCLoth(
      FinishMaintenanceOnClothRequest request) async {
    return await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path:
          "profiles/closet/cloth/${request.serviceId}/services/${request.actionId}/finish",
      expectedCode: 200,
    );
  }

  Future<GetCurrentMaintenanceActionRequest> getCurrentServiceActivity(
      String clothId) async {
    return GetCurrentMaintenanceActionRequest.fromJson(
        await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/closet/cloth/$clothId/services/current",
      expectedCode: 200,
    ));
  }
}
