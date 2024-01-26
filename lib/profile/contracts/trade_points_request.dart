import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class TradePointsRequest implements BaseJsonRequest {
  final int ecoCoins;
  final int sustainablePoints;

  TradePointsRequest(
    this.ecoCoins,
    this.sustainablePoints,
  );

  @override
  Map<String, dynamic> toJson() => {};
}
