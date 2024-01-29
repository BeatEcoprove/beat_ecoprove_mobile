import 'package:beat_ecoprove/profile/presentation/settings/send_feedback/send_feedback_form.dart';
import 'package:beat_ecoprove/profile/presentation/settings/send_feedback/send_feedback_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class SendFeedbackView extends StatelessWidget {
  const SendFeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<SendFeedbackViewModel>(),
      child: const SendFeedbackForm(),
    );
  }
}
