import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_page_params.dart';
import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_params.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/client/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/get_nested_profiles_use_case.dart';

class ChangeProfileViewModel extends ViewModel {
  final INotificationProvider _notificationProvider;
  final AuthenticationService _authService;
  final AuthenticationProvider _authProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final INavigationManager _navigationRouter;
  late final User _user;
  late NestedProfilesResult _profilesResult;

  ChangeProfileViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getNestedProfilesUseCase,
    this._deleteProfileUseCase,
    this._authService,
  ) {
    _user = _authProvider.appUser;
    _profilesResult = NestedProfilesResult.empty();
  }

  User get user => _user;
  NestedProfilesResult get profilesResult => _profilesResult;

  Future<void> getNestedProfiles() async {
    try {
      _profilesResult = await _getNestedProfilesUseCase.handle();
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
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

  Future selectProfile(String profileId, {isMain = false}) async {
    if (isMain) {
      _authProvider.setProfile();
    } else {
      _authProvider.setProfile(profileId: profileId);
    }

    await refreshTokens();
    _notificationProvider.showNotification(
      "Perfil alterado!",
      type: NotificationTypes.success,
    );

    _navigationRouter.pop();
  }

  Future promoteProfile(String profileId) async {
    _authProvider.setProfile();

    await _navigationRouter.replaceTopAsync(
      ProfileRoutes.addparams,
      extras: PageParams(profileId),
    );

    notifyListeners();
  }

  Future<void> deleteProfile(String profileId) async {
    try {
      await _deleteProfileUseCase.handle(profileId);

      _authProvider.setProfile();

      _navigationRouter.replaceTop(CoreRoutes.showCompleted,
          extras: ShowCompletedViewParams(
              text: "Perfil foi removido.",
              textButton: "Continuar",
              action: () => _navigationRouter.pop()));
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  void settings() {
    _navigationRouter.push(ProfileRoutes.settings);
  }

  Future refreshTokens() async {
    String refreshToken = _authProvider.refreshToken;

    var tokens = await _authService.refreshTokens(
      RefreshTokensRequest(
        refreshToken: refreshToken,
        profileId: _authProvider.profile,
      ),
    );

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    _authProvider.authenticate(
      Authentication(
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
      ),
    );
  }

  Future createProfile() async {
    await _navigationRouter.pushAsync(ProfileRoutes.createprofile);
    notifyListeners();
  }

  void goToPromoteProfile(ProfileResult profile) {
    _navigationRouter.push(
      CoreRoutes.makeProfileAction,
      extras: MakeProfileActionViewParams(
        text: "Tem a certeza que pretende criar uma conta com este perfil?",
        textButton: "Criar",
        profile: profile,
        action: () async => await promoteProfile(profile.id),
      ),
    );
  }

  void goToDeleteProfile(ProfileResult profile) {
    _navigationRouter.push(
      CoreRoutes.makeProfileAction,
      extras: MakeProfileActionViewParams(
        text: "Tem a certeza que pretende remover este perfil?",
        textButton: "Remover",
        profile: profile,
        action: () async => await deleteProfile(profile.id),
      ),
    );
  }
}
