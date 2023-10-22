import 'package:beat_ecoprove/home/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: const [WelcomeCard()],
      ),
    );
  }
}
