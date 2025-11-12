import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';

class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final int levelPercent;
  final int sustainablePoints;
  final int ecoScore;
  final int ecoCoins;
  final int xp;
  final int nextLevelXp;
  final UserType type;
  final Phone phoneNumber;

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
    required this.type,
    required this.phoneNumber,
  })  : level = int.parse(level),
        levelPercent = int.tryParse(levelPercent) ?? 0,
        sustainablePoints = int.parse(sustainablePoints),
        ecoScore = int.parse(ecoScore),
        ecoCoins = int.parse(ecoCoins),
        xp = int.parse(xp),
        nextLevelXp = int.parse(nextLevelXp);
}

enum UserType implements Comparable<UserType> {
  consumer(value: "client"),
  organization(value: "organization"),
  employee(value: "employee");

  final String value;

  const UserType({required this.value});

  static UserType getOf(String value) =>
      UserType.values.singleWhere((element) => element.value == value);

  @override
  int compareTo(UserType other) {
    throw UnimplementedError();
  }
}
