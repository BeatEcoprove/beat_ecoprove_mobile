import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';

abstract class FormViewModel<TArgument> extends ViewModel<TArgument> {
  final Map<FormFieldValues, FormFieldModel> _fields = {};

  Map<FormFieldValues, FormFieldModel> get fields => _fields;

  void clearErrors(FormFieldValues key) {
    var formModel = getValue(key);
    formModel.clean();
  }

  void setError(FormFieldValues key, String error) {
    var formModel = getValue(key);
    formModel.setError(error);

    notifyListeners();
  }

  void setValue<T>(FormFieldValues key, T value) {
    var formModel = getValue(key);
    formModel.setValue(value);
    clearErrors(key);

    notifyListeners();
  }

  FormFieldModel getValue<T>(FormFieldValues key) {
    var value = _fields[key];

    if (value == null) return FormFieldModel.empty();

    return value;
  }

  void initializeFields(List<FormFieldValues> fieldStrings) {
    for (FormFieldValues key in fieldStrings) {
      _fields[key] = FormFieldModel.empty();
    }
  }

  T getDefault<T>(FormFieldValues key) {
    var value = getValue(key);

    if (value.isValueEmpty) {
      return "" as T;
    }

    return value.value.toString() as T;
  }

  get thereAreErrors => _fields.values
      .any((element) => element.error.isNotEmpty || _hasValue(element));

  bool _hasValue(FormFieldModel formValue) {
    if (formValue.value == null) {
      return true;
    }

    if (formValue is String && (formValue as String).isEmpty) {
      return true;
    }

    return false;
  }
}
