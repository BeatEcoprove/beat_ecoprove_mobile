import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class AuthenticationProvider extends ViewModel {
  late User? _appUser;
  late String? _accessToken;
  late String? _refreshToken;

  AuthenticationProvider() {
    _appUser = null;
    _accessToken = null;
  }

  void checkAuth() async {
    String refreshToken =
        await StorageService.getValue(Store.refreshToken) ?? '';

    if (refreshToken.isEmpty || !validateToken(refreshToken)) return;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(refreshToken);

    authenticate(
      Authentication.bare(
          refreshToken: refreshToken,
          user: User(
              name: decodedToken[Tokens.name],
              avatarUrl: decodedToken[Tokens.avatarUrl],
              level: decodedToken[Tokens.level],
              levelPercent: decodedToken[Tokens.levelPercent],
              sustainablePoints: decodedToken[Tokens.sustainablePoints])),
    );
  }

  bool validateToken(String refreshToken) {
    if (refreshToken.isEmpty) {
      return false;
    }

    return !JwtDecoder.isExpired(refreshToken);
  }

  void authenticate(Authentication authentication) {
    StorageService.setValue(Store.refreshToken, authentication.refreshToken);

    _appUser = authentication.user;
    _accessToken = authentication.accessToken;
    _refreshToken = authentication.refreshToken;

    notifyListeners();
  }

  void logout() async {
    await StorageService.clearValue(Store.refreshToken);
    _appUser == null;
  }

  String get refreshToken => _refreshToken!;
  String get accessToken => _accessToken!;
  User get appUser => _appUser!;

  bool accessTokenIsValid() {
    if (_accessToken == null) {
      return false;
    }

    if (validateToken(_accessToken!)) {
      return false;
    }

    return true;
  }

  bool get isAuthenticated => !(_appUser != null);
}
