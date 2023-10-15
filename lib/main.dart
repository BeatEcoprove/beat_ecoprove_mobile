import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() {
  // create di container
  DependencyInjection().setupDIContainer();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SignInView()),
    );
  }
}
