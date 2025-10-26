class ProfileResult {
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
  final String role;

  ProfileResult(
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
    this.role,
  );

  factory ProfileResult.empty() {
    return ProfileResult('', '', 0, 0, 0, 0, '', 0, 0, 0, "consumer");
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
        json['ecoCoins'],
        json['xp'],
        json['nextLevelUp'],
        json['role']);
  }
}
