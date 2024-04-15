import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await StorageService.initStorage();

  var app = DependencyInjection().setupDIContainer();
  app.build();

  var provider = DependencyInjection.locator<StaticValuesProvider>();
  await provider.fetchStaticValues();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              DependencyInjection.locator<AuthenticationProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DependencyInjection.locator<INotificationProvider>()
                  as NotificationProvider,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DependencyInjection.locator<NotificationManager>(),
        ),
        ChangeNotifierProvider(
          create: (context) => DependencyInjection.locator<LevelUpProvider>(),
        )
      ],
      child: MainApp(
        appRouter: app.navigationManager.router,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final GoRouter appRouter;

  const MainApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
