import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/language_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/services/internet_service.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:beat_ecoprove/core/locales/l10n/app_localizations.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await StorageService.initStorage();

  var app = DependencyInjection().setupDIContainer();
  app.build();

  var internetService = DependencyInjection.locator<InternetService>();

  var isAuthenticated =
      await DependencyInjection.locator<AuthenticationProvider>().checkAuth();
  if (await internetService.checkServerApiConnection() && isAuthenticated) {
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
          create: (context) => DependencyInjection.locator<LanguageProvider>(),
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
        isAuthenticated: isAuthenticated,
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  final GoRouter appRouter;
  final bool isAuthenticated;

  const MainApp({
    super.key,
    required this.appRouter,
    required this.isAuthenticated,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  AppUpdateInfo? _updateInfo;
  bool _isFirstResume = true;

  @override
  void initState() {
    super.initState();
    _checkForUpdate();
    WidgetsBinding.instance.addObserver(this);

    if (widget.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DependencyInjection.locator<IPhoenixWsNotifier>().logIn();
      });
    }

    DependencyInjection.locator<LanguageProvider>().initializeLanguage();
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

  late final LanguageProvider _languageProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageProvider = DependencyInjection.locator<LanguageProvider>();
    _languageProvider.initializeLanguage();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _languageProvider.deviceLanguage();

      if (_isFirstResume) {
        _isFirstResume = false;
        return;
      }

      try {
        DependencyInjection.locator<IPhoenixWsNotifier>().reconnect();
      } catch (e) {
        print('WebSocket reconnect error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamBuilder<Locale>(
        stream: DependencyInjection.locator<LanguageProvider>().localeStream,
        initialData: const Locale('en'),
        builder: (context, localeSnapshot) {
          return MaterialApp.router(
            theme: ThemeData(fontFamily: 'Lato'),
            debugShowCheckedModeBanner: false,
            routerConfig: widget.appRouter,
            locale: localeSnapshot.data,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              LocaleContext.initializeContext(context);
              return child ?? const SizedBox();
            },
          );
        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
