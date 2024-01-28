import 'package:beat_ecoprove/auth/contracts/resetpassword_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordViewModel extends FormViewModel {
  final GoRouter _navigationRouter;
  final AuthenticationService _authenticationService;

  ResetPasswordViewModel(this._navigationRouter, this._authenticationService) {
    initializeFields([
      FormFieldValues.password,
      FormFieldValues.confirmPassword,
    ]);
  }

  void setPassword(String password) {
    var confirmPassword = getValue(FormFieldValues.confirmPassword).value ?? "";

    if (password != confirmPassword) {
      setError(FormFieldValues.password, "As palavras-chaves devem ser iguais");
      setError(FormFieldValues.confirmPassword,
          "As palavras-chaves devem ser iguais");
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
      setError(FormFieldValues.password, "As palavras-chaves devem ser iguais");
      setError(FormFieldValues.confirmPassword,
          "As palavras-chaves devem ser iguais");
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

    try {
      await _authenticationService.resetPassword(ResetPasswordRequest(
        code,
        password,
      ));

      _navigationRouter.pop();
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }
}
