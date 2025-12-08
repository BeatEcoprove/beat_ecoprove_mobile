class PublicProfilesResult {
  List<PublicProfileResult> profiles;

  PublicProfilesResult(
    this.profiles,
  );

  factory PublicProfilesResult.empty() {
    return PublicProfilesResult([]);
  }

  factory PublicProfilesResult.fromJson(List<dynamic> response) {
    final results = response.map((item) {
      return PublicProfileResult.fromJson(item);
    }).toList();

    return PublicProfilesResult(results);
  }
}

class PublicProfileResult {
  final String id;
  final String username;
  final int level;
  final int sustainabilityPoints;
  final int ecoScorePoints;
  final String avatarUrl;

  PublicProfileResult(
    this.id,
    this.username,
    this.level,
    this.sustainabilityPoints,
    this.ecoScorePoints,
    this.avatarUrl,
  );

  factory PublicProfileResult.fromJson(Map<String, dynamic> json) {
    return PublicProfileResult(
      json['id'] ?? '',
      json['display_name'] ?? '',
      json['level'] ?? 0,
      json['sustainability_points'] ?? 0,
      json['eco_score'] ?? 0,
      json['avatar_url'] ?? '',
    );
  }
}
