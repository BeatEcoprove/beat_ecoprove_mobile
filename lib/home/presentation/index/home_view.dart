import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_form.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<HomeViewModel>(),
        child: const HomeForm());
  }
}
