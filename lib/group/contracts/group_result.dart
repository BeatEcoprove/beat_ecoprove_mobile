class GroupResult {
  final String id;
  final String name;
  final String description;
  final int membersCount;
  final int sustainablePoints;
  final int xp;
  final bool isPublic;
  final String avatarPicture;

  GroupResult(
    this.id,
    this.name,
    this.description,
    this.membersCount,
    this.sustainablePoints,
    this.xp,
    this.isPublic,
    this.avatarPicture,
  );

  factory GroupResult.fromJson(Map<String, dynamic> json) {
    return GroupResult(
      json['id'] ?? '',
      json['name'] ?? '',
      json['description'] ?? '',
      json['member_count'] ?? 0,
      (json['sustainability_points'] as double).toInt() ?? 0,
      (json['xp'] as double).toInt() ?? 0,
      json['is_public'] ?? false,
      json['avatar_url'] ?? '',
    );
  }
}
