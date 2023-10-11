import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  setupDIContainer();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: LoginView()),
    );
  }
}
