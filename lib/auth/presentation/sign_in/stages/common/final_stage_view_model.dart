import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';

class FinalStageViewModel extends StageViewModel {
  final AuthenticationService _authenticationService;

  late bool isLoading = false;
  late bool isPassword = false;

  FinalStageViewModel(super.signInViewModel, this._authenticationService) {
    initializeFields([
      FormFieldValues.email,
      FormFieldValues.password,
      FormFieldValues.confirmPassword
    ]);
  }

  void setPasswordVisibitlity(bool? value) {
    isPassword = value ?? value != null;
    notifyListeners();
  }

  Future<void> setEmail(String email) async {
    email = email.trim();

    try {
      bool isValid = await _authenticationService
          .validateFields(ValidateFieldRequest("email", email));

      if (!isValid) {
        setError(
          FormFieldValues.email,
          LocaleContext.get().auth_final_stage_email_already_used,
        );

        return;
      }
      // ignore: empty_catches
    } on HttpError {}

    try {
      setValue<String>(FormFieldValues.email, Email.create(email).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.email, e.message);
    }
  }

  void setPassword(String password) {
    var confirmPassword = getValue(FormFieldValues.confirmPassword).value ?? "";

    if (password != confirmPassword) {
      setError(
        FormFieldValues.password,
        LocaleContext.get().auth_final_stage_password_must_be_the_same,
      );

      setError(
        FormFieldValues.confirmPassword,
        LocaleContext.get().auth_final_stage_password_must_be_the_same,
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
        LocaleContext.get().auth_final_stage_password_must_be_the_same,
      );

      setError(
        FormFieldValues.confirmPassword,
        LocaleContext.get().auth_final_stage_password_must_be_the_same,
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

  Future handleSignIn(SignInController controller) async {
    isLoading = true;
    notifyListeners();

    await controller.nextPage(fields);

    isLoading = false;
    notifyListeners();
  }
}
