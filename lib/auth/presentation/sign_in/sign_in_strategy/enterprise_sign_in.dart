import 'package:beat_ecoprove/auth/contracts/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/domain/model/form_field_model.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_enterprise_use_case.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';

class EnterpriseSignIn implements SignInStratagy {
  final SignInEnterpriseUseCase _signInEnterpriseUseCase;

  EnterpriseSignIn(this._signInEnterpriseUseCase);

  @override
  Future<AuthResult> handleSignIn(
      Map<FormFieldValues, FormFieldModel> dataList) async {
    var request = SignInEnterpriseRequest(
        name: getFormValue(dataList, FormFieldValues.name),
        typeOption: getFormValue(dataList, FormFieldValues.typeOption),
        phone: getFormValue(dataList, FormFieldValues.phone),
        country: getFormValue(dataList, FormFieldValues.country),
        address: Address.create(
            getFormValue(dataList, FormFieldValues.street),
            getFormValue(dataList, FormFieldValues.port),
            getFormValue(dataList, FormFieldValues.locality),
            getFormValue(dataList, FormFieldValues.postalCode)),
        userName: getFormValue(dataList, FormFieldValues.userName),
        image: Uri.file(getFormValue(dataList, FormFieldValues.avatar)),
        email: getFormValue(dataList, FormFieldValues.email),
        password: getFormValue(dataList, FormFieldValues.password));

    return _signInEnterpriseUseCase.handle(request);
  }

  @override
  getFormValue(Map<FormFieldValues, FormFieldModel<dynamic>> dataList,
          FormFieldValues value) =>
      dataList[value]!.value;
}
