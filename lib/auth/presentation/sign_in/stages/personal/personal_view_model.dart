import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';

class PersonalViewModel extends StageViewModel {
  final StaticValuesProvider _staticValuesProvider;

  late final Map<String, String> countryCodes;

  PersonalViewModel(
    super.signInViewModel,
    this._staticValuesProvider,
  ) {
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
    countryCodes = _staticValuesProvider.countryCodes;
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
          LocaleContext.get().auth_personal_insert_first_name_after_the_second,
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

  setDate(DateTime date) {
    setValue(FormFieldValues.bornDate, date);
  }
}
