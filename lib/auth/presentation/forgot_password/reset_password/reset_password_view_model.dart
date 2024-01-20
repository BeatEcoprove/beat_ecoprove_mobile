import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordViewModel extends FormViewModel {
  final GoRouter _navigationRouter;

  ResetPasswordViewModel(this._navigationRouter) {
    initializeFields([
      FormFieldValues.email,
      FormFieldValues.password,
      FormFieldValues.confirmPassword
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
}
