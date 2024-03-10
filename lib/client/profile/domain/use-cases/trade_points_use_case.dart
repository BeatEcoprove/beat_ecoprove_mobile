import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
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
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
