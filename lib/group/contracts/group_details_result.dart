import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/public_profile_result.dart';

class GroupDetailsResult {
  final String id;
  final String name;
  final String description;
  final int membersCount;
  final int sustainablePoints;
  final int xp;
  final bool isPublic;
  final String avatarPicture;
  final FinishProfileResult creator;
  final List<dynamic> membersIds;
  final List<dynamic> adminsIds;
  late PublicProfilesResult? members = PublicProfilesResult.empty();
  late PublicProfilesResult? admins = PublicProfilesResult.empty();

  GroupDetailsResult(
    this.id,
    this.name,
    this.description,
    this.membersCount,
    this.sustainablePoints,
    this.xp,
    this.isPublic,
    this.avatarPicture,
    this.creator,
    this.membersIds,
    this.adminsIds,
  );

  factory GroupDetailsResult.empty() {
    return GroupDetailsResult(
      '',
      '',
      '',
      0,
      0,
      0,
      false,
      '',
      FinishProfileResult.empty(),
      [],
      [],
    );
  }

  factory GroupDetailsResult.fromJson(Map<String, dynamic> json) {
    return GroupDetailsResult(
      json['id'] ?? '',
      json['name'] ?? '',
      json['description'] ?? '',
      json['member_count'] ?? 0,
      (json['sustainability_points'] as double).toInt(),
      (json['xp'] as double).toInt(),
      json['is_public'] ?? false,
      json['avatar_url'] ?? '',
      FinishProfileResult.fromJson(json['creator'] ?? {}),
      json['members'] ?? [],
      json['mods'] ?? [],
    );
  }
}
