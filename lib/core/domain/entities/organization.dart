import 'package:beat_ecoprove/core/domain/entities/user.dart';

class Organization extends User {
  Organization({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.level,
    required super.levelPercent,
    required super.sustainablePoints,
    required super.ecoScore,
    required super.ecoCoins,
    required super.xp,
    required super.nextLevelXp,
    super.type = UserType.organization,
  });
}
