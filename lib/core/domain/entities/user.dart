class User {
  final String name;
  final Uri avatarUrl;
  final int level;
  final double levelPercent;
  final int sustainablePoints;

  User(
      {required this.name,
      required String avatarUrl,
      required String level,
      required String levelPercent,
      required String sustainablePoints})
      : avatarUrl = Uri.parse(avatarUrl),
        level = int.parse(level),
        levelPercent = double.parse(levelPercent),
        sustainablePoints = int.parse(sustainablePoints);
}
