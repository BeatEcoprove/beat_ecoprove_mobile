class ImageResult {
  final String httpUrl;

  ImageResult(this.httpUrl);

  factory ImageResult.fromJson(Map<String, dynamic> json) {
    return ImageResult(
      json['url'] ?? '',
    );
  }
}
