import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_view_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  static const double headerGap = 36;

  final SignUserType? userType;

  const SignInView({this.userType, Key? key}) : super(key: key);

  SignUserType getUserType() {
    if (userType == null) throw Exception("There is no user type");

    return userType!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        SignInProviders.signInViewModelProvider(),
        SignInProviders.personalViewModelProvider(),
        SignInProviders.enterpriseStageViewModelProvider(),
        SignInProviders.enterpriseAddressViewModelProvider(),
        SignInProviders.avatarViewModelProvider(),
        SignInProviders.finalStageViewModelProvider()
      ],
      child: Scaffold(
        body: SignInViewController(
          type: getUserType(),
        ),
      ),
    );
  }
}

class SignInProviders {
  static ChangeNotifierProvider<SignInViewModel> signInViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) => DependencyInjection.locator<SignInViewModel>(),
    );
  }

  static ChangeNotifierProvider<PersonalViewModel> personalViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) => DependencyInjection.locator<PersonalViewModel>(),
    );
  }

  static ChangeNotifierProvider<EnterpriseStageViewModel>
      enterpriseStageViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) =>
          DependencyInjection.locator<EnterpriseStageViewModel>(),
    );
  }

  static ChangeNotifierProvider<EnterpriseAddressStageViewModel>
      enterpriseAddressViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) =>
          DependencyInjection.locator<EnterpriseAddressStageViewModel>(),
    );
  }

  static ChangeNotifierProvider<AvatarStageViewModel>
      avatarViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) => DependencyInjection.locator<AvatarStageViewModel>(),
    );
  }

  static ChangeNotifierProvider<FinalStageViewModel>
      finalStageViewModelProvider() {
    return ChangeNotifierProvider(
      create: (context) => DependencyInjection.locator<FinalStageViewModel>(),
    );
  }
}
