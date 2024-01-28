import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class WebSocketMessage extends BaseJsonRequest {
  final String type;

  WebSocketMessage(this.type);

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
