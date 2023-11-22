import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_form.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class RegisterClothView extends StatelessWidget {
  const RegisterClothView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<RegisterClothViewModel>(),
      child: const RegisterClothForm(),
    );
  }
}
