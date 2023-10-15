import 'package:beat_ecoprove/auth/presentation/select_user/select_user_form.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:flutter/material.dart';

class SelectUserView extends StatelessWidget {
  const SelectUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoBack(child: SelectUserForm()),
    );
  }
}
