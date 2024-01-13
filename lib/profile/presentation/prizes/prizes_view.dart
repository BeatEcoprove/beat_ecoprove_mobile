import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/presentation/prizes/prizes_view_form.dart';
import 'package:beat_ecoprove/profile/presentation/prizes/prizes_view_model.dart';
import 'package:flutter/material.dart';

class PrizesView extends StatelessWidget {
  const PrizesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<PrizesViewModel>(),
        child: const PrizesForm());
  }
}
