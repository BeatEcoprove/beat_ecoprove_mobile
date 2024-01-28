enum WebsocketMessageType implements Comparable<WebsocketMessageType> {
  levelUp(value: "LevelUp"),
  inviteToGroup(value: "InviteToGroup");

  final String value;

  const WebsocketMessageType({required this.value});

  static WebsocketMessageType getOf(String value) => WebsocketMessageType.values
      .singleWhere((element) => element.value == value);

  static List<WebsocketMessageType> getAllTypes() {
    return WebsocketMessageType.values.toList();
  }

  @override
  toString() => value;

  @override
  int compareTo(WebsocketMessageType other) {
    throw UnimplementedError();
  }
}
