import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_form.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  final ResetPasswordParams params;

  const ResetPasswordView({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<ResetPasswordViewModel>(),
        child: ResetPasswordForm(
          params: params,
        ));
  }
}
