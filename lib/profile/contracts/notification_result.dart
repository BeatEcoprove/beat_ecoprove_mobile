class NotificationResult {
  final String userId;
  final String title;
  final String group;
  final String invitor;
  final String code;

  NotificationResult(
    this.userId,
    this.title,
    this.group,
    this.invitor,
    this.code,
  );

  static List<NotificationResult> fromJsonArray(List<dynamic> collectionJson) {
    return collectionJson.map((e) {
      return NotificationResult.fromJson(e);
    }).toList();
  }

  factory NotificationResult.fromJson(Map<String, dynamic> json) {
    return NotificationResult(
      json['userId'],
      json['title'],
      json['groupId'],
      json['invitorId'],
      json['code'],
    );
  }
}
