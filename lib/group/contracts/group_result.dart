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
      json['id'],
      json['name'],
      json['description'],
      json['membersCount'],
      json['sustainablePoints'],
      json['xp'],
      json['isPublic'],
      json['avatarPicture'],
    );
  }
}
