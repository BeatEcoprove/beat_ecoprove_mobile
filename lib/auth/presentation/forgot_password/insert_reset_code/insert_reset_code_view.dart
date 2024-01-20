import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_form.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class InsertResetCodeView extends StatelessWidget {
  const InsertResetCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<InsertResetCodeViewModel>(),
        child: const InsertResetCodeForm());
  }
}
