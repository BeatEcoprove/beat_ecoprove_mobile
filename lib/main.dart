import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await StorageService.initStorage();

  DependencyInjection().setupDIContainer();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) =>
            DependencyInjection.locator<AuthenticationProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            DependencyInjection.locator<NotificationProvider>(),
      )
    ],
    child: MainApp(
      appRouter: DependencyInjection.locator<AppRouter>(),
      notificationProvider: DependencyInjection.locator<NotificationProvider>(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  final NotificationProvider notificationProvider;

  const MainApp({
    super.key,
    required this.appRouter,
    required this.notificationProvider,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    notificationProvider.setContext(context);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.appRouter,
    );
  }
}
