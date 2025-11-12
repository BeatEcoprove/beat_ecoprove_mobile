import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

class PersonalSignIn implements SignInStratagy {
  final RegistrationService _registrationService;
  final Map<FormFieldValues, FormFieldModel> dataList;

  PersonalSignIn(this._registrationService, this.dataList);

  @override
  Future<FinishProfileResult> createProfile() async {
    try {
      var profile = await _registrationService.getTokenData();

      String name = getFormValue(dataList, FormFieldValues.name);

      var request = SignInPersonalRequest(
          profileId: profile.profileId,
          firstName: name.split(' ')[0],
          lastName: name.split(' ')[1],
          displayName: getFormValue(dataList, FormFieldValues.userName),
          birthDate: getFormValue(dataList, FormFieldValues.bornDate),
          gender: Gender.getOf(getFormValue(dataList, FormFieldValues.gender)),
          phone: getFormValue(dataList, FormFieldValues.phone));

      return await _registrationService.createClient(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  getFormValue(Map<FormFieldValues, FormFieldModel> dataList,
          FormFieldValues value) =>
      dataList[value]!.value;
}
