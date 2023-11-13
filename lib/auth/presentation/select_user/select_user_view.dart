import 'package:beat_ecoprove/auth/presentation/select_user/select_user_form.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class SelectUserView extends StatelessWidget {
  const SelectUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<SelectUserViewModel>(),
      child: const Scaffold(
        body: GoBack(
          posTop: 48,
          posLeft: 22,
          child: SelectUserForm(),
        ),
      ),
    );
  }
}
