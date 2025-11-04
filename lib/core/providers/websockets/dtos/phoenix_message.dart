class PhoenixMessage {
  final String topic;
  final String event;
  final Map<String, dynamic> payload;
  final String ref;

  PhoenixMessage({
    required this.topic,
    required this.event,
    required this.payload,
    required this.ref,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'event': event,
      'payload': payload,
      'ref': ref,
    };
  }

  factory PhoenixMessage.fromJson(Map<String, dynamic> json) {
    return PhoenixMessage(
      topic: json['topic'] ?? '',
      event: json['event'] ?? '',
      payload: json['payload'] ?? {},
      ref: json['ref'] ?? '',
    );
  }

  factory PhoenixMessage.join(String topic, String ref) {
    return PhoenixMessage(
      topic: topic,
      event: 'phx_join',
      payload: {},
      ref: ref,
    );
  }

  factory PhoenixMessage.leave(String topic, String ref) {
    return PhoenixMessage(
      topic: topic,
      event: 'phx_leave',
      payload: {},
      ref: ref,
    );
  }

  bool get isJoinReply => event == 'phx_reply' && payload['status'] == 'ok';

  bool get isErrorReply => event == 'phx_reply' && payload['status'] == 'error';

  bool get isPhxEvent => event.startsWith('phx_');
}
