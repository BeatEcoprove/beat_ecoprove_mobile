import 'package:beat_ecoprove/auth/contracts/forgotpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_internalserver_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class LoginViewModel extends FormViewModel {
  final LoginUseCase _loginUseCase;
  final AuthenticationService _authenticationService;
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;

  LoginViewModel(
    this._loginUseCase,
    this._navigationRouter,
    this._authenticationService,
    this._notificationProvider,
  ) {
    initializeFields([
      FormFieldValues.email,
      FormFieldValues.password,
    ]);
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setEmail(String email) {
    try {
      setValue(FormFieldValues.email, Email.create(email).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.email, e.message);
    }
  }

  void setPassword(String password) {
    try {
      setValue(FormFieldValues.password, Password.create(password).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.password, e.message);
    }
  }

  Future handleForgotPassword() async {
    var email = getValue(FormFieldValues.email);
    var emailValue = email.value ?? "";

    if (email.error.isNotEmpty || emailValue.isEmpty) {
      setError(FormFieldValues.email, email.error);
      notifyListeners();
      return;
    }

    try {
      await _authenticationService
          .sendForgotPassword(ForgotPasswordRequest(emailValue));

      await _navigationRouter.pushAsync(AuthRoutes.resetCode);
    } on HttpInternalError catch (e) {
      setError(FormFieldValues.email, e.getError().title);
    } catch (e) {
      return;
    }
  }

  void handleSignUp() {
    _navigationRouter.push(AuthRoutes.selectUser);
  }

  void handleLogin() async {
    var email = getValue(FormFieldValues.email).value ?? "";
    var password = getValue(FormFieldValues.password).value ?? "";

    setLoading(true);

    try {
      await _loginUseCase.handle(LoginRequest(email, password));

      _navigationRouter.push(AppRoute.root);
    } catch (e) {
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    setLoading(false);

    await DependencyInjection.locator<IWCNotifier>().logIn();
    notifyListeners();
  }
}
