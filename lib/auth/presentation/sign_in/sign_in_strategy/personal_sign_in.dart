import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

class PersonalSignIn implements SignInStratagy {
  final AuthenticationService _authenticationService;
  final Map<FormFieldValues, FormFieldModel> dataList;

  PersonalSignIn(this._authenticationService, this.dataList);

  @override
  Future<AuthResult> createProfile() async {
    var request = SignInPersonalRequest(
        name: getFormValue(dataList, FormFieldValues.name),
        bornDate: getFormValue(dataList, FormFieldValues.bornDate),
        gender: Gender.getOf(getFormValue(dataList, FormFieldValues.gender)),
        userName: getFormValue(dataList, FormFieldValues.userName),
        avatarPicture: getFormValue(dataList, FormFieldValues.avatar),
        email: getFormValue(dataList, FormFieldValues.email),
        password: getFormValue(dataList, FormFieldValues.password),
        phone: getFormValue(dataList, FormFieldValues.phone));

    try {
      return await _authenticationService.createProfilePersonal(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  getFormValue(Map<FormFieldValues, FormFieldModel> dataList,
          FormFieldValues value) =>
      dataList[value]!.value;
}
