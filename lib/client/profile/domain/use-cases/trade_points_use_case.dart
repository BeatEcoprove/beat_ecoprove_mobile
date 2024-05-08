import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/trade_points_request.dart';
import 'package:beat_ecoprove/client/profile/services/exchange_service.dart';

class TradePointsUseCase implements UseCase<TradePointsRequest, Future> {
  final ExchangeService _exchangeService;

  TradePointsUseCase(this._exchangeService);

  @override
  Future handle(TradePointsRequest request) async {
    try {
      await _exchangeService.tradePoints(request);
    } catch (e) {
      rethrow;
    }
  }
}
