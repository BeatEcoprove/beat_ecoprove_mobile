import 'package:beat_ecoprove/auth/contracts/forgotpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends FormViewModel {
  final LoginUseCase _loginUseCase;
  final AuthenticationService _authenticationService;
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;

  late final TextEditingController passwordTextController;

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

    passwordTextController = TextEditingController(
      text: getValue(FormFieldValues.password).value ?? "",
    );
  }

  late bool isLoading = false;
  late bool isPassword = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setPasswordVisibitlity(bool? value) {
    isPassword = value ?? value != null;
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
      setError(FormFieldValues.email, "Por favor, introduza um email válido");
      notifyListeners();
      return;
    }

    var checkIfEmailExists = await _authenticationService
        .validateFields(ValidateFieldRequest("email", emailValue));

    if (checkIfEmailExists) {
      return _notificationProvider.showNotification(
        "O utilizador com o email ${email.value} não existe",
        type: NotificationTypes.error,
      );
    }

    _authenticationService
        .sendForgotPassword(ForgotPasswordRequest(emailValue))
        .catchError(
      (e) {
        _notificationProvider.showNotification(
          e.getError().title,
          type: NotificationTypes.error,
        );

        _navigationRouter.pop();
      },
    );

    _navigationRouter.pushAsync(
      AuthRoutes.resetCode,
    );

    _notificationProvider.showNotification(
      "O pedido foi enviado!",
      type: NotificationTypes.success,
    );
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
      await DependencyInjection.locator<IWCNotifier>().logIn();

      _navigationRouter.push(AppRoute.root);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );

      clearPasswordText();
    } catch (e) {
      print(e.toString());
      clearPasswordText();
    }

    setLoading(false);

    notifyListeners();
  }

  void clearPasswordText() {
    setValue(FormFieldValues.password, "");
    passwordTextController.clear();
  }
}
