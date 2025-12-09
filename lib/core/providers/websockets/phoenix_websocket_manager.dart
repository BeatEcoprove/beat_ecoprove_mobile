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
  Timer? _heartbeatTimer;
  int _refCounter = 0;

  static const Duration heartbeatInterval = Duration(seconds: 30);

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

    try {
      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {
          'Origin': 'http://localhost',
        },
        pingInterval: const Duration(seconds: 20),
      );

      await _channel!.ready;

      _controller = StreamController<dynamic>.broadcast();
      _broadcastStream = _controller!.stream;

      _channel!.stream.listen(
        (data) {
          _controller!.add(data);
          _handleIncomingMessage(data);
        },
        onError: (error) {
          print('WebSocket stream error: $error');
          _controller!.addError(error);
          _handleDisconnection();
        },
        onDone: () {
          print('WebSocket closed by the server');
          _handleDisconnection();
        },
      );

      _isFullyConnected = true;
      _startHeartbeat();
      print('WebSocket successfully connected!');
      return _broadcastStream!;
    } catch (e, s) {
      _isFullyConnected = false;
      close();
      print('Fatal WebSocket error: $e\n$s');
      rethrow;
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
      if (_isFullyConnected && _channel != null) {
        try {
          final heartbeat = {
            'topic': 'phoenix',
            'event': 'heartbeat',
            'payload': {},
            'ref': '${_refCounter++}',
          };
          _channel!.sink.add(convert.jsonEncode(heartbeat));
          print('Heartbeat sent');
        } catch (e) {
          print('Error sending heartbeat: $e');
          _handleDisconnection();
        }
      } else {
        print('⚠️ Heartbeat cancelled: connection unavailable');
        timer.cancel();
      }
    });
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final decoded = convert.jsonDecode(data);

      print('📨 Message received: ${decoded['event']}');

      if (decoded['event'] == 'phx_reply') {
        final status = decoded['payload']?['status'];
        print('✅ Phoenix reply: $status');
      }
    } catch (e) {
      print('⚠️ Error processing message: $e');
    }
  }

  void _handleDisconnection() {
    print('🔌 Disconnecting...');
    _isFullyConnected = false;
    _heartbeatTimer?.cancel();
    _controller?.close();
  }

  @override
  void sendMessage(PhoenixMessage message) {
    if (!_isFullyConnected || _channel == null) {
      throw Exception('WebSocket not connected');
    }
    try {
      _channel!.sink.add(convert.jsonEncode(message.toJson()));
    } catch (e) {
      print('Error sending message: $e');
      _handleDisconnection();
      rethrow;
    }
  }

  @override
  void close() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _isFullyConnected = false;
    _controller?.close();
    _controller = null;
    _broadcastStream = null;
    _channel?.sink.close();
    _channel = null;
    _currentToken = null;
  }

  @override
  bool isAlive() =>
      _isFullyConnected && _channel != null && _broadcastStream != null;

  @override
  Stream<dynamic> get stream {
    if (_broadcastStream == null) {
      throw StateError('Call createChannel first');
    }
    return _broadcastStream!;
  }
}
