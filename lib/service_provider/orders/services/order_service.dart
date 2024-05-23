import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/service_provider/orders/contracts/order_result.dart';

class OrderService {
  final HttpAuthClient _httpClient;

  OrderService(this._httpClient);

  Future<List<OrderResult>> getOrders(
    String filters, {
    int page = 1,
    int pageSize = 50,
  }) async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "orders?page=$page&pageSize=$pageSize$filters",
      expectedCode: 200,
    );

    return result.map((orderJson) => OrderResult.fromJson(orderJson)).toList();
  }
}
