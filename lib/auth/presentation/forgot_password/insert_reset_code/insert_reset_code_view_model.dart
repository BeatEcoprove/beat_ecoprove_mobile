import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/code.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_params.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';

class InsertResetCodeViewModel extends FormViewModel {
  final INavigationManager _navigationRouter;

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

    _navigationRouter.replaceTop("/reset_password",
        extras: ResetPasswordParams(
          code: code,
        ));
  }
}
