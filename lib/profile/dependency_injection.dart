import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/presentation/prizes/prizes_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/profile/profile_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/settings/settings_view_model.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension ProfileDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();

    locator.registerFactory(
        () => ProfileViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => SettingsViewModel(authProvider, router.appRouter));
    locator
        .registerFactory(() => PrizesViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => TradePointsViewModel(authProvider, router.appRouter));
  }

  void addProfile() {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
  }
}
