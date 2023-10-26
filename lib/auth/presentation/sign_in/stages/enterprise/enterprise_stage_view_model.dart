import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

class EnterpriseStageViewModel extends FormViewModel {
  final List<String> _typeOptions = [];

  EnterpriseStageViewModel() {
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.phone,
      FormFieldValues.typeOption,
    ]);

    _typeOptions.addAll(["Lavandaria", "Reparação"]);
    setValue(FormFieldValues.typeOption, _typeOptions.first);
  }

  List<String> get typeOptions => _typeOptions;

  void setName(String name) {
    int spaceCount = name.split(" ").length - 1;

    if (spaceCount == 0 || spaceCount > 1) {
      return;
    }

    var [firstName, lastName] = name.split(" ");

    try {
      setValue<String>(
          FormFieldValues.name, Name.create(firstName, lastName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  void setPhone(String phone) {
    try {
      setValue<Phone>(FormFieldValues.phone, Phone.create("+351", phone));
    } on DomainException catch (e) {
      setError(FormFieldValues.phone, e.message);
    }
  }
}
