import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';

class EnterpriseStageViewModel extends StageViewModel {
  final StaticValuesProvider _staticValuesProvider;

  final List<String> _typeOptions = [];
  late final Map<String, String> countryCodes;

  EnterpriseStageViewModel(
    super.signInViewModel,
    this._staticValuesProvider,
  ) {
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.phone,
      FormFieldValues.typeOption,
    ]);

    _typeOptions.addAll([
      LocaleContext.get().auth_enterprise_service_provider_laundry,
      LocaleContext.get().auth_enterprise_service_provider_repair,
    ]);

    setValue(FormFieldValues.typeOption, _typeOptions.first);
    countryCodes = _staticValuesProvider.countryCodes;
  }

  List<String> get typeOptions => _typeOptions;

  @override
  setDefaults(Map<FormFieldValues, FormFieldModel> data) {
    super.setDefaults(data);

    setToDefaultField(
      FormFieldValues.typeOption,
      data[FormFieldValues.typeOption]?.value ?? _typeOptions.first,
    );
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

  void setPhone(String countryCode, String phone) {
    try {
      setValue<Phone>(FormFieldValues.phone, Phone.create(countryCode, phone));
    } on DomainException catch (e) {
      setError(FormFieldValues.phone, e.message);
    }
  }
}
