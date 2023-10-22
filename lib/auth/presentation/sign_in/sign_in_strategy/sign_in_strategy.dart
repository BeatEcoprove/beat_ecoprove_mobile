import 'package:beat_ecoprove/auth/contracts/auth_result.dart';
import 'package:beat_ecoprove/auth/domain/model/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';

abstract class SignInStratagy {
  Future<AuthResult> handleSignIn(
      Map<FormFieldValues, FormFieldModel> dataList);

  getFormValue(Map<FormFieldValues, FormFieldModel<dynamic>> dataList,
      FormFieldValues value);
}
