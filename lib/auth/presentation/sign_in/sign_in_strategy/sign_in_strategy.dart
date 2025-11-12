import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

abstract class SignInStratagy {
  Future<FinishProfileResult> createProfile();

  getFormValue(Map<FormFieldValues, FormFieldModel<dynamic>> dataList,
      FormFieldValues value);
}
