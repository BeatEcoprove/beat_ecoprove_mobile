import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';

class PersonalViewModel extends FormViewModel {
  PersonalViewModel() {
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.bornDate,
      FormFieldValues.phone,
      FormFieldValues.gender,
    ]);

    setValue(FormFieldValues.gender, Gender.getAllTypes().firstOrNull);
    setValue(FormFieldValues.bornDate, DateTime.now());
  }

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
