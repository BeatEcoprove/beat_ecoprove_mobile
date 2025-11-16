class FinishProfileResult {
  final String id;
  final String username;
  final int level;
  final int levelPercentage;
  final int sustainabilityPoints;
  final int ecoScorePoints;
  final String avatarUrl;
  final int ecoCoins;
  final int xp;
  final int nextLevelUp;
  final String phoneNumber;
  final String phoneCountry;

  FinishProfileResult(
    this.id,
    this.username,
    this.level,
    this.levelPercentage,
    this.sustainabilityPoints,
    this.ecoScorePoints,
    this.avatarUrl,
    this.ecoCoins,
    this.xp,
    this.nextLevelUp,
    this.phoneNumber,
    this.phoneCountry,
  );

  factory FinishProfileResult.empty() {
    return FinishProfileResult('', '', 0, 0, 0, 0, '', 0, 0, 0, '', '');
  }

  factory FinishProfileResult.fromJson(Map<String, dynamic> json) {
    return FinishProfileResult(
      json['id'] ?? '',
      json['username'] ?? '',
      json['level'] ?? 0,
      json['level_percentage'] ?? 0,
      json['sustainability_points'] ?? 0,
      json['eco_score'] ?? 0,
      json['avatar_url'] ?? '',
      json['eco_coins'] ?? 0,
      json['xp'] ?? 0,
      json['next_level_up'] ?? 0,
      json['phone_number'] ?? '000000000',
      json['phone_country'] ?? '',
    );
  }
}
