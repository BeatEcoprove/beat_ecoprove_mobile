import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/contracts/image_request.dart';
import 'package:beat_ecoprove/core/contracts/image_result.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/services/upload_image_service.dart';
import 'package:image_picker/image_picker.dart';

class EnterpriseSignIn implements SignInStratagy {
  final RegistrationService _registrationService;
  final UploadImageService _uploadImageService;
  final Map<FormFieldValues, FormFieldModel> dataList;

  EnterpriseSignIn(
    this._registrationService,
    this._uploadImageService,
    this.dataList,
  );

  @override
  Future<FinishProfileResult> createProfile() async {
    var profile = await _registrationService.getTokenData();
    String name = getFormValue(dataList, FormFieldValues.name);
    //FIXME: Upload image will be enabled later
    // XFile avatar = getFormValue(dataList, FormFieldValues.avatar);

    // ImageResult result = await _uploadImageService.upload(ImageRequest(avatar));

    var request = SignInEnterpriseRequest(
      profileId: profile.profileId,
      firstName: name.split(' ')[0],
      lastName: name.split(' ')[1],
      displayName: getFormValue(dataList, FormFieldValues.userName),
      phone: getFormValue(dataList, FormFieldValues.phone),
      country: getFormValue(dataList, FormFieldValues.country),
      address: Address.create(
          getFormValue(dataList, FormFieldValues.street),
          getFormValue(dataList, FormFieldValues.port),
          getFormValue(dataList, FormFieldValues.locality),
          getFormValue(dataList, FormFieldValues.postalCode)),
      // picture: result.httpUrl,
      picture: '',
    );

    try {
      return await _registrationService.createOrganization(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  getFormValue(Map<FormFieldValues, FormFieldModel<dynamic>> dataList,
          FormFieldValues value) =>
      dataList[value]!.value;
}
