import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_enterprise_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_personal_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/enterprise_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/personal_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class SignInViewModel extends ViewModel {
  final SignInPersonalUseCase _signInPersonalUseCase;
  final SignInEnterpriseUseCase _signInEnterpriseUseCase;
  final INavigationManager _navigationRouter;
  final Map<FormFieldValues, FormFieldModel> dataList = {};

  SignInViewModel(
    this._navigationRouter,
    this._signInPersonalUseCase,
    this._signInEnterpriseUseCase,
  );

  void persist(Map<FormFieldValues, FormFieldModel> data) {
    dataList.addAll(data);
  }

  void handleNext(Map<FormFieldValues, FormFieldModel> data) {
    persist(data);
  }

  void handleSignIn(SignUseroptions signType) async {
    SignInStratagy strategy;

    if (signType.label == SignUseroptions.personal.label) {
      strategy = PersonalSignIn(_signInPersonalUseCase);
    } else {
      strategy = EnterpriseSignIn(_signInEnterpriseUseCase);
    }

    try {
      await strategy.handleSignIn(dataList);
      await DependencyInjection.locator<IWCNotifier>().logIn();

      await _navigationRouter.pushAsync("/show_completed",
          extras: ShowCompletedViewParams(
            text: "Conta criada com sucesso",
            textButton: "Entrar",
            action: () => _navigationRouter.push("/"),
          ));
    } catch (e) {
      // TODO: Put some sort of way of telling the user that someting went wrong with he's register
      return;
    }
  }
}
