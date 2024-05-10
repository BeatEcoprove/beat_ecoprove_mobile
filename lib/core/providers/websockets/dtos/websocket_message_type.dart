enum WebsocketMessageType implements Comparable<WebsocketMessageType> {
  levelUp(value: "LevelUpNotificationEvent"),
  inviteToGroup(value: "InviteGroupNotificationEvent"),
  connectToGroup(value: "EnterOnGroupNotificationEvent"),
  sendTextMessage(value: "SentGroupTextMessageEvent"),
  sendTradeOfferMessage(value: "SendGroupBorrowMessageEvent"),
  chatTextMessage(value: "TextMessage"),
  borrowMessage(value: "BorrowClothMessage"),
  serverChatMessage(value: "ServerChatMessage"),
  errorMessage(value: "MessageNotificationEvent"),
  notifyBorrowRequestAccepted(value: "NotifyBorrowExchangeEndedEvent");

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
