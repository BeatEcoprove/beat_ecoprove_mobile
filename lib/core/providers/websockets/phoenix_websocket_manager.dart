import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';
import 'dart:convert' as convert;

abstract class IPhoenixWebSocketManager {
  Future<Stream<dynamic>> createChannel(String jwtToken);
  void sendMessage(PhoenixMessage message);
  void close();
  bool isAlive();
  Stream<dynamic> get stream;
}

class PhoenixWebSocketManager implements IPhoenixWebSocketManager {
  WebSocketChannel? _channel;
  Stream<dynamic>? _broadcastStream;
  StreamController<dynamic>? _controller;
  String? _currentToken;
  bool _isFullyConnected = false;

  @override
  Future<Stream<dynamic>> createChannel(String jwtToken) async {
    if (_broadcastStream != null && _currentToken == jwtToken && isAlive()) {
      return _broadcastStream!;
    }

    close();
    _currentToken = jwtToken;
    _isFullyConnected = false;

    final uri = Uri.parse(ServerConfig.websocketUrl).replace(
      queryParameters: {'token': jwtToken},
    );
    print('Conectando WebSocket: $uri');
    try {
      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {
          'Origin': 'http://localhost',
        },
      );

      await _channel!.ready;

      _controller = StreamController<dynamic>.broadcast();
      _broadcastStream = _controller!.stream;

      _channel!.stream.listen(
        _controller!.add,
        onError: _controller!.addError,
        onDone: () {
          _controller!.close();
          print('WebSocket fechado pelo servidor');
        },
      );

      _isFullyConnected = true;
      print('WebSocket conectado com sucesso via web_socket_channel!');
      return _broadcastStream!;
    } catch (e, s) {
      _isFullyConnected = false;
      close();
      print('Erro fatal WebSocket: $e\n$s');
      rethrow;
    }
  }

  @override
  void sendMessage(PhoenixMessage message) {
    if (!_isFullyConnected || _channel == null) {
      throw Exception('WebSocket não conectado (ainda não ready)');
    }
    _channel!.sink.add(convert.jsonEncode(message.toJson()));
  }

  @override
  void close() {
    _isFullyConnected = false;
    _controller?.close();
    _controller = null;
    _broadcastStream = null;
    _channel?.sink.close();
    _channel = null;
  }

  @override
  bool isAlive() => _channel != null && _broadcastStream != null;

  @override
  Stream<dynamic> get stream {
    if (_broadcastStream == null)
      throw StateError('Chame createChannel primeiro');
    return _broadcastStream!;
  }
}
