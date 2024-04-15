import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_stage.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class SignUseroptions {
  final String label;

  const SignUseroptions(this.label);

  List<Stage> getStages(
    SignInController controller,
    SignInViewModel viewModel,
  ) {
    switch (label) {
      case "personal":
        return [
          PersonalStage(
            controller: controller,
            viewModel: PersonalViewModel(
              viewModel,
              DependencyInjection.locator<StaticValuesProvider>(),
            ),
          ),
          AvatarStage(
            viewModel: AvatarStageViewModel(
              viewModel,
              DependencyInjection.locator<AuthenticationService>(),
            ),
            controller: controller,
          ),
          FinalStage(
            viewModel: FinalStageViewModel(
              viewModel,
              DependencyInjection.locator<AuthenticationService>(),
            ),
            controller: controller,
          ),
        ];
      case "enterprise":
        return [
          EnterpriseStage(
            viewModel: EnterpriseStageViewModel(
              viewModel,
              DependencyInjection.locator<StaticValuesProvider>(),
            ),
            controller: controller,
          ),
          EnterpriseAddressStage(
            viewModel: EnterpriseAddressStageViewModel(
              viewModel,
              DependencyInjection.locator<StaticValuesProvider>(),
            ),
            controller: controller,
          ),
          AvatarStage(
            viewModel: AvatarStageViewModel(
              viewModel,
              DependencyInjection.locator<AuthenticationService>(),
            ),
            controller: controller,
          ),
          FinalStage(
            viewModel: FinalStageViewModel(
              viewModel,
              DependencyInjection.locator<AuthenticationService>(),
            ),
            controller: controller,
          ),
        ];
      default:
        throw Exception("Invalid user type: $label");
    }
  }

  static SignUseroptions personal = const SignUseroptions("personal");
  static SignUseroptions enterprise = const SignUseroptions("enterprise");

  static SignUseroptions getTypeOf(String? value) {
    if (value == null) {
      return SignUseroptions.personal;
    }

    switch (value) {
      case "personal":
        return SignUseroptions.personal;
      case "enterprise":
        return SignUseroptions.enterprise;
      default:
        throw Exception("Invalid user type: $value");
    }
  }
}
