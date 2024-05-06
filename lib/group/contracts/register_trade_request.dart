import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RegisterTradeRequest implements BaseJsonRequest {
  final String groupId;
  final String messageId;
  final String profileId;

  RegisterTradeRequest(
    this.groupId,
    this.messageId,
    this.profileId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
    };
  }
}
