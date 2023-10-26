import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

abstract class SignInStratagy {
  Future handleSignIn(Map<FormFieldValues, FormFieldModel> dataList);

  getFormValue(Map<FormFieldValues, FormFieldModel<dynamic>> dataList,
      FormFieldValues value);
}
