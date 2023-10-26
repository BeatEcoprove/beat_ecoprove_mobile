import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.initStorage();

  DependencyInjection().setupDIContainer();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) =>
              DependencyInjection.locator<AuthenticationProvider>())
    ],
    child: MainApp(
      appRouter: DependencyInjection.locator<AppRouter>(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;

  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.appRouter,
    );
  }
}
