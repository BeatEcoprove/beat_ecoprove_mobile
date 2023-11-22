import 'package:beat_ecoprove/register_cloth/dependency_injection.dart';
import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/clothing/dependency_injection.dart';
import 'package:beat_ecoprove/clothing/routes.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/home/dependency_injection.dart';
import 'package:beat_ecoprove/register_cloth/routes.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  void setupDIContainer() {
    var authProvider = locator.registerSingleton(AuthenticationProvider());
    authProvider.checkAuth();

    locator.registerSingleton(
        AppRouter([authRoutes, clothingRoutes, registerClothRoutes]));

    locator.registerFactory(() => HttpClient());

    addAuth();
    addHome();
    addClothing();
    addCloth();
  }
}
