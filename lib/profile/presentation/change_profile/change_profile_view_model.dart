import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final AuthenticationService _authService;
  final AuthenticationProvider _authProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final GoRouter _navigationRouter;
  late final User _user;
  late ProfilesResult _profilesResult;

  ChangeProfileViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getNestedProfilesUseCase,
    this._deleteProfileUseCase,
    this._authService,
  ) {
    _user = _authProvider.appUser;
    _profilesResult = ProfilesResult.empty();
  }

  User get user => _user;
  ProfilesResult get profilesResult => _profilesResult;

  Future<void> getNestedProfiles() async {
    try {
      _profilesResult = await _getNestedProfilesUseCase.handle();
    } catch (e) {
      print("$e");
    }
  }

  String get nestedProfile => _authProvider.profileId;
  bool get isNestedProfilesEmpty => _authProvider.profileId.isNotEmpty;

  bool selectedProfile(String profileId, bool isMain) {
    if (isMain && nestedProfile.isEmpty) {
      return true;
    }

    if (nestedProfile.isNotEmpty && nestedProfile == profileId) {
      return true;
    }

    return false;
  }

  void selectProfile(String profileId, {isMain = false}) {
    refreshTokens();

    if (isMain) {
      _authProvider.setProfile();
    } else {
      _authProvider.setProfile(profileId: profileId);
    }

    _notificationProvider.showNotification(
      "Perfil alterado!",
      type: NotificationTypes.success,
    );

    _navigationRouter.pop();
  }

  Future promoteProfile(String profileId) async {
    // clean profileId
    _authProvider.setProfile();

    await _navigationRouter.pushReplacement(
      "/addparams",
      extra: profileId,
    );

    notifyListeners();
  }

  Future<void> deleteProfile(String profileId) async {
    try {
      await _deleteProfileUseCase.handle(profileId);

      // clean profileId
      _authProvider.setProfile();

      _navigationRouter.pushReplacement("/show_completed",
          extra: ShowCompletedViewParams(
              text: "Perfil foi removido.",
              textButton: "Continuar",
              action: () => _navigationRouter.pop()));
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    notifyListeners();
  }

  void settings() {
    _navigationRouter.push('/settings');
  }

  Future refreshTokens() async {
    String refreshToken = _authProvider.refreshToken;

    var tokens = await _authService.refreshTokens(RefreshTokensRequest(
        refreshToken: refreshToken, profileId: _authProvider.profile));

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    _authProvider.authenticate(Authentication(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
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
    ));
  }

  Future createProfile() async {
    await _navigationRouter.push("/createprofile");
    notifyListeners();
  }
}
