import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/profile/contracts/trade_points_request.dart';

class ExchangeService {
  final HttpAuthClient _httpClient;

  ExchangeService(this._httpClient);

  Future<void> tradePoints(TradePointsRequest request) async {
    return await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path:
          "extension/concurrency/convert?ecoCoins=${request.ecoCoins}&sustainabilityPoints=${request.sustainablePoints}",
      expectedCode: 200,
    );
  }
}
