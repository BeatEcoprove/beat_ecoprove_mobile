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
    String refreshToken = //await StorageService.getValue(Store.refreshToken) ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyMmVjMmI2MS00YjI0LTRlZTAtOWIxMy1lNWE2ZmY0YWQzMDIiLCJlbWFpbCI6ImRhdmlkYnJhZ2FAZXhhbXBsZS5jb20iLCJnaXZlbl9uYW1lIjoiZGF2aWRfYnJhZ2EiLCJhdmF0YXJfdXJsIjoiaHR0cDovL2xvY2FsaG9zdDo1MTgyL3B1YmxpYy9wcm9maWxlL2ExZThjNzhmLWMwYmYtNDYyYy05ZTVlLTU4Y2IyMmU1NGY0MC5wbmciLCJsZXZlbCI6IjEwIiwibGV2ZWxfcGVyY2VudGFnZSI6IjEwIiwic3VzdGFpbmFibGVfcG9pbnRzIjoiMTAiLCJleHAiOjE3MDAzMjA0ODMsImlzcyI6IkludmVzdG1lbnRCYW5rU3lzdGVtcyIsImF1ZCI6IkludmVzdG1lbnQgQmFuayBTeXN0ZW1zIn0.jEsIlXJ67RKvaNYBijfitM1MYVqLL2zSS1PH4JSxdqY';

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

    return JwtDecoder.isExpired(refreshToken);
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

  bool get isAuthenticated => _appUser != null;
}
