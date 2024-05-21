import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/group/contracts/chat_messages.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/remove_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/add_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/register_store_request.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/store_result.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/worker_result.dart';

class StoreService {
  final HttpAuthClient _httpClient;

  StoreService(this._httpClient);

  Future<List<StoreResult>> getStores(
    String filters, {
    int page = 1,
    int pageSize = 10,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "stores?page=$page&pageSize=$pageSize$filters",
      expectedCode: 200,
    );

    return result.map((storeJson) => StoreResult.fromJson(storeJson)).toList();
  }

  Future registerStore(RegisterStoreRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "stores",
      body: request,
      expectedCode: 200,
    );
  }

  Future<List<WorkerResult>> getStoreWorkers(
    String storeId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "stores/$storeId/workers?page=$page&pageSize=$pageSize",
      expectedCode: 200,
    );

    return result
        .map((workerJson) => WorkerResult.fromJson(workerJson))
        .toList();
  }

  Future addWorker(AddWorkerRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.put,
      path: "stores/${request.storeId}/workers",
      body: request,
      expectedCode: 201,
    );
  }

  Future removeWorker(RemoveWorkerRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "stores/${request.storeId}/workers/${request.id}",
      body: request,
      expectedCode: 200,
    );
  }

  Future changeWorkerType(AddWorkerRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "stores/${request.storeId}/workers/${request.id}",
      body: request,
      expectedCode: 204,
    );
  }

  Future<ChatMessages> getReviews(
    String storeId,
    String filters, {
    int page = 1,
    int pageSize = 10,
  }) async {
    var response = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "stores/$storeId/messages?page=$page&pageSize=$pageSize$filters",
      expectedCode: 200,
    );

    return ChatMessages.fromJson(response);
  }
}
