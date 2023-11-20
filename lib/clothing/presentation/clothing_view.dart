import 'package:beat_ecoprove/clothing/presentation/clothing_form.dart';
import 'package:beat_ecoprove/clothing/presentation/clothing_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class ClothingView extends StatelessWidget {
  const ClothingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<ClothingViewModel>(),
      child: const ClothingForm(),
    );
  }
}
