import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';

class GroupDetailsResult {
  final String id;
  final String name;
  final String description;
  final int membersCount;
  final int sustainablePoints;
  final int xp;
  final bool isPublic;
  final String avatarPicture;
  final ProfileResult creator;
  final List<ProfileResult> members;
  final List<ProfileResult> admins;

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
    this.members,
    this.admins,
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
      ProfileResult.empty(),
      [],
      [],
    );
  }

  factory GroupDetailsResult.fromJson(Map<String, dynamic> json) {
    return GroupDetailsResult(
      json['id'],
      json['name'],
      json['description'],
      json['members_count'],
      json['sustainability_points'],
      json['xp'],
      json['is_public'],
      json['avatar_url'],
      ProfileResult.fromJson(json['creator']),
      _convertJsonToProfileResultList(json['members']),
      _convertJsonToProfileResultList(json['admins']),
    );
  }

  static List<ProfileResult> _convertJsonToProfileResultList(
      List<dynamic> groups) {
    var group = groups.map((item) {
      return ProfileResult.fromJson(item);
    }).toList();

    return group;
  }
}
