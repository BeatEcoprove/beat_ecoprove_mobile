import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  // create di container
  DependencyInjection().setupDIContainer();
  runApp(const MainApp());
}

final GoRouter appRouter = GoRouter(routes: [authRoutes]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
