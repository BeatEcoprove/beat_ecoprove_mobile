class InviteGroupNotificationResult {
  final String groupId;
  final String senderId;
  final String code;

  InviteGroupNotificationResult(
    this.groupId,
    this.senderId,
    this.code,
  );

  factory InviteGroupNotificationResult.fromJson(Map<String, String> json) {
    return InviteGroupNotificationResult(
      json['groupId'] ?? "",
      json['invitorId'] ?? "",
      json['code'] ?? "",
    );
  }
}
