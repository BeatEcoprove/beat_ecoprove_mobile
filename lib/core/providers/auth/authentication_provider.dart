import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class AuthenticationProvider extends ViewModel {
  late bool _isAuthenticated = false;
  late String profileId = '';
  late User? _appUser;
  late String? _accessToken;
  late String _refreshToken = '';

  AuthenticationProvider() {
    _appUser = null;
    _accessToken = null;
  }

  Future checkAuth() async {
    String refreshToken =
        await StorageService.getValue(Store.refreshToken) ?? '';

    _refreshToken = refreshToken;

    if (refreshToken.isEmpty || !validateToken(refreshToken)) return;

    DependencyInjection.locator<IWCNotifier>().logIn();

    Map<String, dynamic> decodedToken = JwtDecoder.decode(refreshToken);

    authenticate(
      Authentication.bare(
        refreshToken: refreshToken,
        user: User(
          id: decodedToken[Tokens.id],
          name: decodedToken[Tokens.name],
          avatarUrl: decodedToken[Tokens.avatarUrl],
          level: decodedToken[Tokens.level],
          levelPercent: decodedToken[Tokens.levelPercent],
          sustainablePoints: decodedToken[Tokens.sustainablePoints],
          ecoScore: decodedToken[Tokens.ecoScore],
          ecoCoins: decodedToken[Tokens.ecoCoins],
          xp: decodedToken[Tokens.xp],
          nextLevelXp: decodedToken[Tokens.nextLevelXp],
        ),
      ),
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
    _isAuthenticated = true;

    notifyListeners();
  }

  Future logout() async {
    DependencyInjection.locator<IWCNotifier>().logOut();
    await StorageService.clearValue(Store.refreshToken);
    _appUser = null;
    _isAuthenticated = false;
    await DependencyInjection.locator<INavigationManager>()
        .pushAsync(AuthRoutes.login);
  }

  String get profile => profileId;
  String get refreshToken => _refreshToken;
  String get accessToken => _accessToken!;
  User? get appUser => _appUser;

  void setProfile({String profileId = ""}) {
    this.profileId = profileId;
    notifyListeners();
  }

  bool accessTokenIsValid() {
    if (_accessToken == null) {
      return false;
    }

    if (validateToken(_accessToken!)) {
      return false;
    }

    return true;
  }

  bool get isAuthenticated => _isAuthenticated;
}
