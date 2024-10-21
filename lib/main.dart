import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/services/internet_service.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await StorageService.initStorage();

  var app = DependencyInjection().setupDIContainer();
  app.build();

  var internetService = DependencyInjection.locator<InternetService>();

  if (await internetService.checkServerApiConnection()) {
    await DependencyInjection.locator<AuthenticationProvider>().checkAuth();

    var provider = DependencyInjection.locator<StaticValuesProvider>();
    await provider.fetchStaticValues();
  }

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

class MainApp extends StatefulWidget {
  final GoRouter appRouter;

  const MainApp({
    super.key,
    required this.appRouter,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  Future<void> _checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      setState(() {
        _updateInfo = updateInfo;
      });

      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        _forceUpdate();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _forceUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      routerConfig: widget.appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
