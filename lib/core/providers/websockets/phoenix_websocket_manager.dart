import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as convert;

abstract class IPhoenixWebSocketManager {
  void sendMessage(PhoenixMessage message);
  void close();
  Future<IOWebSocketChannel> createChannel(String jwtToken);
  bool isAlive();
  Stream<dynamic> get stream;
}

class PhoenixWebSocketManager implements IPhoenixWebSocketManager {
  final Uri url;
  late String authorizationToken = '';
  late bool isConnectionAlive = false;
  IOWebSocketChannel? _session;

  PhoenixWebSocketManager(String url) : url = Uri.parse(url);

  @override
  Future<IOWebSocketChannel> createChannel(String jwtToken) async {
    var baseUrl = Uri.parse(ServerConfig.websocketUrl);
    authorizationToken = jwtToken;

    final wsUrl = baseUrl.replace(queryParameters: {
      ...baseUrl.queryParameters,
      'token': authorizationToken,
    });

    _session = IOWebSocketChannel.connect(wsUrl);

    await _session!.ready;
    isConnectionAlive = true;
    return _session!;
  }

  @override
  void sendMessage(PhoenixMessage message) {
    if (_session == null || !isAlive()) {
      throw Exception('WebSocket não está conectado');
    }

    var jsonContent = message.toJson();
    var jsonString = convert.jsonEncode(jsonContent);

    _session!.sink.add(jsonString);
  }

  @override
  void close() {
    if (isAlive() && _session != null) {
      _session!.sink.close();
      isConnectionAlive = false;
      _session = null;
    }
  }

  @override
  bool isAlive() {
    return _session != null && _session!.closeCode == null;
  }

  @override
  Stream<dynamic> get stream {
    if (_session == null) {
      throw Exception('WebSocket não está conectado');
    }
    return _session!.stream;
  }
}
