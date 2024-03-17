import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';

class PersonalViewModel extends StageViewModel {
  PersonalViewModel(super.signInViewModel) {
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.bornDate,
      FormFieldValues.phone,
      FormFieldValues.gender,
    ]);

    setValue(
      FormFieldValues.gender,
      Gender.getAllTypes().firstOrNull?.displayValue,
    );

    setValue(FormFieldValues.bornDate, DateTime.now());
  }

  @override
  void setDefaults(Map<FormFieldValues, FormFieldModel> data) {
    super.setDefaults(data);

    setToDefaultField(
      FormFieldValues.bornDate,
      data[FormFieldValues.bornDate]?.value ?? DateTime.now(),
    );

    setToDefaultField(
      FormFieldValues.gender,
      data[FormFieldValues.gender]?.value ??
          Gender.getAllTypes().firstOrNull?.displayValue,
    );
  }

  void setName(String name) {
    try {
      int spaceCount = name.split(" ").length - 1;

      if (spaceCount == 0 || spaceCount > 1) {
        throw DomainException(
          "Insira o seu primeiro e segundo nome separado por um espaço.",
        );
      }

      var [firstName, lastName] = name.split(" ");

      setValue<String>(
          FormFieldValues.name, Name.create(firstName, lastName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  void setPhone(String countryCode, String phone) {
    try {
      setValue<Phone>(FormFieldValues.phone, Phone.create(countryCode, phone));
    } on DomainException catch (e) {
      setError(FormFieldValues.phone, e.message);
    }
  }
}
