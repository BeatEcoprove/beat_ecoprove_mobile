class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final double levelPercent;
  final int sustainablePoints;
  final int ecoScore;
  final int ecoCoins;
  final int xp;
  final int nextLevelXp;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required String level,
    required String levelPercent,
    required String sustainablePoints,
    required String ecoScore,
    required String ecoCoins,
    required String xp,
    required String nextLevelXp,
  })  : level = int.parse(level),
        levelPercent = double.tryParse(levelPercent) ?? 0,
        sustainablePoints = int.parse(sustainablePoints),
        ecoScore = int.parse(ecoScore),
        ecoCoins = int.parse(ecoCoins),
        xp = int.parse(xp),
        nextLevelXp = int.parse(nextLevelXp);
}
