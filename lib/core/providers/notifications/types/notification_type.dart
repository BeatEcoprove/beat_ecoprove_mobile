enum NotifictionType implements Comparable<NotifictionType> {
  inviteToGroup(value: "InviteToGroup");

  final String value;

  const NotifictionType({required this.value});

  static NotifictionType getOf(String value) =>
      NotifictionType.values.singleWhere((element) => element.value == value);

  static List<NotifictionType> getAllTypes() {
    return NotifictionType.values.toList();
  }

  @override
  toString() => value;

  @override
  int compareTo(NotifictionType other) {
    throw UnimplementedError();
  }
}
