import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_request.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_use_case.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/enterprise_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/personal_sign_in.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class SignInViewModel extends ViewModel {
  final INavigationManager _navigationRouter;
  final RegistrationService _registrationService;
  final INotificationProvider _notificationProvider;
  final SignInUseCase _signInUseCase;

  final Map<FormFieldValues, FormFieldModel> dataList = {};

  SignInViewModel(
    this._navigationRouter,
    this._registrationService,
    this._notificationProvider,
    this._signInUseCase,
  );

  void persist(Map<FormFieldValues, FormFieldModel> data) {
    dataList.addAll(data);
  }

  void handleNext(Map<FormFieldValues, FormFieldModel> data) {
    persist(data);
  }

  Future handleSignIn(SignUseroptions signType) async {
    SignInStratagy strategy;
    String email = dataList[FormFieldValues.email]!.value;
    String password = dataList[FormFieldValues.password]!.value;

    if (signType.label == SignUseroptions.personal.label) {
      strategy = PersonalSignIn(_registrationService, dataList);
    } else {
      strategy = EnterpriseSignIn(_registrationService, dataList);
    }

    try {
      await _signInUseCase.handle(SignInRequest(
        strategy: strategy,
        email: email,
        password: password,
        role: signType.label,
      ));
      //FIXME: Ws
      // await DependencyInjection.locator<IPhoenixWsNotifier>().logIn();

      await _navigationRouter.pushAsync(CoreRoutes.showCompleted,
          extras: ShowCompletedViewParams(
            text: LocaleContext.get().auth_sign_in_sucess,
            textButton: LocaleContext.get().auth_sign_in_enter,
            action: () => _navigationRouter.push(AppRoute.root),
          ));
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
