import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_page_params.dart';
import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_params.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class ChangeProfileViewModel extends ViewModel {
  final INotificationProvider _notificationProvider;
  final AuthenticationService _authService;
  final AuthenticationProvider _authProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final INavigationManager _navigationRouter;
  late List<FinishProfileResult> _profilesResult;

  ChangeProfileViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getNestedProfilesUseCase,
    this._deleteProfileUseCase,
    this._authService,
  ) {
    _profilesResult = List<FinishProfileResult>.empty();
  }

  FinishProfileResult get mainProfile => FinishProfileResult(
        _authProvider.appUser!.id,
        _authProvider.appUser!.name,
        _authProvider.appUser!.level,
        _authProvider.appUser!.levelPercent,
        _authProvider.appUser!.sustainablePoints,
        _authProvider.appUser!.ecoScore,
        _authProvider.appUser!.avatarUrl,
        _authProvider.appUser!.ecoCoins,
        _authProvider.appUser!.xp,
        _authProvider.appUser!.nextLevelXp,
        _authProvider.appUser!.phoneNumber.value,
        _authProvider.appUser!.phoneNumber.countryCode,
      );
  List<FinishProfileResult> get profilesResult => _profilesResult;

  Future<void> getNestedProfiles() async {
    try {
      _profilesResult = (await _getNestedProfilesUseCase.handle()).profiles;
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
    DependencyInjection.locator<IPhoenixWsNotifier>().logOut();
    //FIXME: Ws
    // await DependencyInjection.locator<IPhoenixWsNotifier>().logIn();

    _notificationProvider.showNotification(
      LocaleContext.get().client_profile_change_profile_profile_alter,
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
              text: LocaleContext.get()
                  .client_profile_change_profile_profile_removed,
              textButton:
                  LocaleContext.get().client_profile_change_profile_continue,
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
        user: switch (UserType.getOf(decodedToken[Tokens.role])) {
          UserType.consumer => Consumer(
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
              phoneNumber: Phone.create(decodedToken[Tokens.phoneCountry],
                  decodedToken[Tokens.phoneNumber]),
            ),
          UserType.organization => Organization(
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
              phoneNumber: Phone.create(decodedToken[Tokens.phoneCountry],
                  decodedToken[Tokens.phoneNumber]),
            ),
          UserType.employee => Employee(
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
              phoneNumber: Phone.create(decodedToken[Tokens.phoneCountry],
                  decodedToken[Tokens.phoneNumber]),
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ),
    );
  }

  Future createProfile() async {
    await _navigationRouter.pushAsync(ProfileRoutes.createprofile);
    notifyListeners();
  }

  void goToPromoteProfile(FinishProfileResult profile) {
    _navigationRouter.push(
      CoreRoutes.makeProfileAction,
      extras: MakeProfileActionViewParams(
        text: LocaleContext.get().client_profile_change_profile_create_account,
        textButton: LocaleContext.get().client_profile_change_profile_create,
        profile: profile,
        action: () async => await promoteProfile(profile.id),
      ),
    );
  }

  void goToDeleteProfile(FinishProfileResult profile) {
    _navigationRouter.push(
      CoreRoutes.makeProfileAction,
      extras: MakeProfileActionViewParams(
        text: LocaleContext.get().client_profile_change_profile_remove_profile,
        textButton: LocaleContext.get().client_profile_change_profile_remove,
        profile: profile,
        action: () async => await deleteProfile(profile.id),
      ),
    );
  }
}
