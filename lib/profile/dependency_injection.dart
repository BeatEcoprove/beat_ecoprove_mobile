import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/promote_profile_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/register_profile_use_case.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/params_page/params_profile_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/create_profile/create_profile_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/prizes/prizes_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/profile/profile_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/settings/settings_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension ProfileDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => ProfileService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var profileService = locator<ProfileService>();

    locator.registerSingleton(RegisterProfileUseCase(profileService));
    locator.registerSingleton(GetNestedProfilesUseCase(profileService));
    locator.registerSingleton(DeleteProfileUseCase(profileService));
    locator.registerSingleton(PromoteProfileUseCase(profileService));
  }

  void _addViewModels(GetIt locator) {
    var authenticationService = locator<AuthenticationService>();
    var notificationProvider = locator<NotificationProvider>();
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();
    var getNestedProfilesUseCase = locator<GetNestedProfilesUseCase>();
    var createProfilesUseCase = locator<RegisterProfileUseCase>();
    var deleteProfileUseCase = locator<DeleteProfileUseCase>();
    var promoteProfileUseCase = locator<PromoteProfileUseCase>();

    locator.registerFactory(
        () => ProfileViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => SettingsViewModel(authProvider, router.appRouter));
    locator
        .registerFactory(() => PrizesViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => TradePointsViewModel(authProvider, router.appRouter));
    locator.registerFactory(() => ChangeProfileViewModel(
        notificationProvider,
        authProvider,
        router.appRouter,
        getNestedProfilesUseCase,
        deleteProfileUseCase,
        locator<AuthenticationService>()));
    locator.registerFactory(() => CreateProfileViewModel(
          notificationProvider,
          router.appRouter,
          createProfilesUseCase,
        ));
    locator.registerFactory(() => ParamsProfileViewModel(
          notificationProvider,
          authProvider,
          authenticationService,
          router.appRouter,
          promoteProfileUseCase,
        ));
  }

  void addProfile() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
