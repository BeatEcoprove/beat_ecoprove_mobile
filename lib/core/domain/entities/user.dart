class User {
  final String name;
  final String avatarUrl;
  final int level;
  final double levelPercent;
  final int sustainablePoints;
  // final int ecoScore;

  User({
    required this.name,
    required this.avatarUrl,
    required String level,
    required String levelPercent,
    required String sustainablePoints,
    // required String ecoScore,
  })  : level = int.parse(level),
        levelPercent = double.parse(levelPercent),
        sustainablePoints = int.parse(sustainablePoints);
  // ecoScore = int.parse(ecoScore);
}
