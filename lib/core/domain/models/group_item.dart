class GroupItem {
  final String id;
  final String name;
  final String description;
  final bool isPublic;
  final int membersCount;
  final int sustainablePoints;
  final int xp;
  final String avatarPicture;

  GroupItem({
    required this.id,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.membersCount,
    required this.sustainablePoints,
    required this.xp,
    required this.avatarPicture,
  });
}
