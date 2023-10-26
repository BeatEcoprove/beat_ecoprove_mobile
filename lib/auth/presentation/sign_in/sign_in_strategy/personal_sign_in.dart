import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_personal_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';

class PersonalSignIn implements SignInStratagy {
  final SignInPersonalUseCase _signInPersonalUseCase;

  PersonalSignIn(this._signInPersonalUseCase);

  @override
  Future handleSignIn(Map<FormFieldValues, FormFieldModel> dataList) async {
    var request = SignInPersonalRequest(
        name: getFormValue(dataList, FormFieldValues.name),
        bornDate: getFormValue(dataList, FormFieldValues.bornDate).toString(),
        gender: getFormValue(dataList, FormFieldValues.gender),
        userName: getFormValue(dataList, FormFieldValues.userName),
        avatarPicture: getFormValue(dataList, FormFieldValues.avatar),
        email: getFormValue(dataList, FormFieldValues.email),
        password: getFormValue(dataList, FormFieldValues.password),
        phone: getFormValue(dataList, FormFieldValues.phone));

    _signInPersonalUseCase.handle(request);
  }

  @override
  getFormValue(Map<FormFieldValues, FormFieldModel> dataList,
          FormFieldValues value) =>
      dataList[value]!.value;
}
