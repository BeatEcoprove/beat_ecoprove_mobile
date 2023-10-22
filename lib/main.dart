import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/providers/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  DependencyInjection().setupDIContainer();
  AppRouter appRouter = AppRouter([authRoutes]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationProvider())
    ],
    child: MainApp(
      appRouter: appRouter,
    ),
  ));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;

  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.appRouter,
    );
  }
}
