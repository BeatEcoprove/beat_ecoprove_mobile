import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/postal_code.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';

class EnterpriseAddressStageViewModel extends StageViewModel {
  final StaticValuesProvider _staticValuesProvider;

  final Map<String, List<String>> _countries = {};

  EnterpriseAddressStageViewModel(
    super.signInViewModel,
    this._staticValuesProvider,
  ) {
    initializeFields([
      FormFieldValues.country,
      FormFieldValues.locality,
      FormFieldValues.street,
      FormFieldValues.port,
      FormFieldValues.postalCode,
    ]);

    _countries.addAll(_staticValuesProvider.countryParishes);
    setValue(FormFieldValues.country, _countries.keys.first);
    setValue(FormFieldValues.locality, getLocalities().first);
  }

  List<String> get countries => _countries.keys.toList();

  List<String> getLocalities() {
    String choosenCountry = getValue(FormFieldValues.country).value!;

    if (choosenCountry.isNotEmpty) {
      return _countries[choosenCountry]!;
    }

    return _countries.values.first;
  }

  void setStreet(String street) {
    if (street.isEmpty) {
      return setError(FormFieldValues.street,
          LocaleContext.get().auth_enterprise_insert_street);
    }

    setValue(FormFieldValues.street, street);
  }

  void setPostalCode(String postalCode) {
    try {
      if (postalCode.isEmpty) {
        throw DomainException(
          LocaleContext.get().auth_enterprise_insert_zip_code,
        );
      }

      setValue(FormFieldValues.postalCode, PostalCode.create(postalCode));
    } on DomainException catch (e) {
      setError(FormFieldValues.postalCode, e.message);
    }
  }

  void setPort(String rawPort) {
    try {
      if (rawPort.isEmpty) {
        throw DomainException(LocaleContext.get().auth_enterprise_insert_port);
      }

      int port = int.parse(rawPort);

      setValue<int>(FormFieldValues.port, port);
    } catch (e) {
      setError(
        FormFieldValues.port,
        LocaleContext.get().auth_enterprise_insert_an_valid_port,
      );
    }
  }
}
