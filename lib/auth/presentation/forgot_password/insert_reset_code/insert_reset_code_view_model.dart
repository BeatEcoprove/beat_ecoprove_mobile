import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/code.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_form.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:go_router/go_router.dart';

class InsertResetCodeViewModel extends FormViewModel {
  final GoRouter _navigationRouter;

  InsertResetCodeViewModel(
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.code,
    ]);
  }

  void setCode(String code) {
    try {
      setValue(FormFieldValues.code, Code.create(code).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.code, e.message);
    }
  }

  void verifyCode() {
    var code = getValue(FormFieldValues.code).value ?? "";

    if (code.isEmpty) {
      setError(FormFieldValues.code, "O código não pode ser vazio");
    }

    _navigationRouter.pushReplacement("/reset_password",
        extra: ResetPasswordParams(
          code: code,
        ));
  }
}
