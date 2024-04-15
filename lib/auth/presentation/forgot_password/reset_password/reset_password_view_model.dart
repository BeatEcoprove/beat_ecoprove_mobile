import 'package:beat_ecoprove/auth/contracts/resetpassword_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';

class ResetPasswordViewModel extends FormViewModel {
  final INavigationManager _navigationRouter;
  final AuthenticationService _authenticationService;
  final INotificationProvider _notificationProvider;

  late bool isLoading = false;
  late bool isPassword = false;

  ResetPasswordViewModel(
    this._navigationRouter,
    this._authenticationService,
    this._notificationProvider,
  ) {
    initializeFields([
      FormFieldValues.password,
      FormFieldValues.confirmPassword,
    ]);
  }

  void setPasswordVisibitlity(bool? value) {
    isPassword = value ?? value != null;
    notifyListeners();
  }

  void setPassword(String password) {
    var confirmPassword = getValue(FormFieldValues.confirmPassword).value ?? "";

    if (password != confirmPassword) {
      setError(
        FormFieldValues.password,
        "As palavras-chaves devem ser iguais",
      );

      setError(
        FormFieldValues.confirmPassword,
        "As palavras-chaves devem ser iguais",
      );
    }

    try {
      setValue<String>(
          FormFieldValues.password, Password.create(password).toString());
      if (password == confirmPassword) {
        clearErrors(FormFieldValues.confirmPassword);
      }
    } on DomainException catch (e) {
      setError(FormFieldValues.password, e.message);
    }
  }

  void setConfirmPassword(String confirmPassword) {
    var password = getValue(FormFieldValues.password).value ?? "";

    if (password != confirmPassword) {
      setError(
        FormFieldValues.password,
        "As palavras-chaves devem ser iguais",
      );

      setError(
        FormFieldValues.confirmPassword,
        "As palavras-chaves devem ser iguais",
      );
    }

    try {
      setValue<String>(FormFieldValues.confirmPassword,
          Password.create(confirmPassword).toString());

      if (password == confirmPassword) clearErrors(FormFieldValues.password);
    } on DomainException catch (e) {
      setError(FormFieldValues.confirmPassword, e.message);
    }
  }

  void handleRefreshPassword(String code) async {
    var password = getValue(FormFieldValues.password).value ?? "";
    isLoading = true;
    notifyListeners();

    try {
      await _authenticationService.resetPassword(
        ResetPasswordRequest(
          code,
          password,
        ),
      );

      _notificationProvider.showNotification(
        "Password Alterada com sucesso!",
        type: NotificationTypes.success,
      );

      _navigationRouter.pop();
    } catch (e) {
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
