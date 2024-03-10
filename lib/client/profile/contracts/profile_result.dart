class ProfileResult {
  final String id;
  final String username;
  final int level;
  final int levelPercentage;
  final int sustainabilityPoints;
  final int ecoScorePoints;
  final String avatarUrl;

  ProfileResult(this.id, this.username, this.level, this.levelPercentage,
      this.sustainabilityPoints, this.ecoScorePoints, this.avatarUrl);

  factory ProfileResult.empty() {
    return ProfileResult('', '', 0, 0, 0, 0, '');
  }

  factory ProfileResult.fromJson(Map<String, dynamic> json) {
    return ProfileResult(
      json['id'],
      json['username'],
      json['level'],
      json['levelPercentage'],
      json['sustainabilityPoints'],
      json['ecoScore'],
      json['avatarUrl'],
    );
  }
}
