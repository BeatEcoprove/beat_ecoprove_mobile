import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/change_profile_view_model.dart';
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

    // locator.registerSingleton(RegisterNestedProfileUseCase(groupService));
    locator.registerSingleton(GetNestedProfilesUseCase(profileService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();
    var getNestedProfilesUseCase = locator<GetNestedProfilesUseCase>();

    locator.registerFactory(
        () => ProfileViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => SettingsViewModel(authProvider, router.appRouter));
    locator
        .registerFactory(() => PrizesViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => TradePointsViewModel(authProvider, router.appRouter));
    locator.registerFactory(() => ChangeProfileViewModel(
        authProvider, router.appRouter, getNestedProfilesUseCase));
  }

  void addProfile() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
