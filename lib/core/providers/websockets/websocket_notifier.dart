import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as convert;

class WSSessionManager {
  final Map<String, IOWebSocketChannel> _channels = {};

  void sendMessage(
      String channelName, WebSocketMessage message, String jwtToken) {
    var socket = _channels[channelName];

    if (socket == null || socket.closeCode != null) {
      socket = createChannel(channelName, jwtToken);
    }

    socket.sink.add(convert.jsonEncode(message.toJson()));
  }

  void removeChannel(String channelName) {
    if (_channels.containsKey(channelName)) {
      _channels[channelName]!.sink.close();
      _channels.remove(channelName);
    }
  }

  IOWebSocketChannel createChannel(String channelName, String jwtToken) {
    var url = Uri.parse(ServerConfig.websocketUrl);

    if (_channels.containsKey(channelName)) {
      removeChannel(channelName);
    }

    _channels[channelName] = IOWebSocketChannel.connect(url,
        headers: {"Authorization": "Bearer $jwtToken"});

    return _channels[channelName]!;
  }
}
