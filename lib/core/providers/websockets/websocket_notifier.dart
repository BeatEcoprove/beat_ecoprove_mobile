import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as convert;

abstract class IWebSocketManager {
  void sendMessage(WebSocketMessage message, String jwtToken);
  void close();
  Future<IOWebSocketChannel> createChannel(String jwtToken);
  bool isAlive();
}

class SingleSessionManager implements IWebSocketManager {
  final Uri url;
  late bool isConnectionAlive = false;
  late IOWebSocketChannel session;

  SingleSessionManager(String url) : url = Uri.parse(url);

  @override
  Future<IOWebSocketChannel> createChannel(String jwtToken) async {
    var url = Uri.parse(ServerConfig.websocketUrl);

    session = IOWebSocketChannel.connect(url,
        headers: {"Authorization": "Bearer $jwtToken"});

    await session.ready;
    return session;
  }

  @override
  void sendMessage(WebSocketMessage message, String jwtToken) {
    try {
      session.sink.add(convert.jsonEncode(message.toJson()));
    } catch (e) {
      print(e);
    }
  }

  @override
  void close() {
    if (isAlive()) {
      session.sink.close();
    }
  }

  @override
  bool isAlive() {
    return session.closeCode == null;
  }
}

class MultiConnectionSessionManager {
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
