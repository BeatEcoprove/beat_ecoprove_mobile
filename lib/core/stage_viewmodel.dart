import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';

abstract class StageViewModel extends FormViewModel {
  final SignInViewModel signInViewModel;

  StageViewModel(this.signInViewModel);

  @override
  void initSync() {
    setDefaults(signInViewModel.dataList);
  }

  void setToDefaultField<TValue>(FormFieldValues key, TValue value) {
    setValue(key, value);
  }

  setDefaults(Map<FormFieldValues, FormFieldModel> data) {
    if (data.isEmpty) {
      return;
    }

    for (var field in fields.keys) {
      var value = data[field]?.value;

      if (value == null) {
        continue;
      }

      setToDefaultField(field, value);
    }
  }
}
