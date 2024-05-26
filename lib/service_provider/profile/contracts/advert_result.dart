class AdvertResult {
  final String advertId;
  final String advertPicture;
  final String title;
  final DateTime beginIn;
  final DateTime endIn;
  final String contentText;
  final String contentSubText;

  AdvertResult(
    this.advertId,
    this.advertPicture,
    this.title,
    this.beginIn,
    this.endIn,
    this.contentText,
    this.contentSubText,
  );

  factory AdvertResult.fromJson(Map<String, dynamic> json) {
    var result = AdvertResult(
      json['id'],
      json['picture'],
      json['title'],
      DateTime.parse(json['beginAt']),
      DateTime.parse(json['endAt']),
      json['contentText'],
      json['contentSubText'],
    );

    return result;
  }
}
