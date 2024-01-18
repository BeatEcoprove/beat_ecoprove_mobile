class ActionResult {
  final String id;
  final String title;
  final String badge;
  final int sustainablePoints;

  ActionResult(
    this.id,
    this.title,
    this.badge,
    this.sustainablePoints,
  );

  factory ActionResult.fromJson(Map<String, dynamic> json) {
    return ActionResult(
      json['id'],
      json['title'],
      json['badge'],
      json['sustainablePoints'],
    );
  }
}
