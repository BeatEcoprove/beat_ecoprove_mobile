import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_enterprise_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_personal_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/enterprise_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/personal_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends ViewModel {
  final SignInPersonalUseCase _signInPersonalUseCase;
  final SignInEnterpriseUseCase _signInEnterpriseUseCase;
  final GoRouter _navigationRouter;
  final Map<FormFieldValues, FormFieldModel> dataList = {};

  SignInViewModel(this._navigationRouter, this._signInPersonalUseCase,
      this._signInEnterpriseUseCase);

  void handleNext(Map<FormFieldValues, FormFieldModel> data) {
    dataList.addAll(data);
  }

  void handleSignIn(SignUserType signType) async {
    SignInStratagy stratagy;

    switch (signType) {
      case SignUserType.personal:
        stratagy = PersonalSignIn(_signInPersonalUseCase);
        break;
      default:
        stratagy = EnterpriseSignIn(_signInEnterpriseUseCase);
    }

    try {
      await stratagy.handleSignIn(dataList);
      _navigationRouter.go("/show_completed",
          extra: ShowCompletedViewParams(
              text: "Conta criada com sucesso", textButton: "Entrar"));
    } catch (e) {
      print("Error on authentication: $e!");
      return;
    }
  }
}
