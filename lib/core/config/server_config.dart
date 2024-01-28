import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServerConfig {
  static String backendUrl = dotenv.env['BACKEND_URL'] ?? '';
  static String websocketUrl = dotenv.env['WEBSOCKETS_URL'] ?? '';
}
