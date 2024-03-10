import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterStoreRequest implements BaseMultiPartRequest {
  final XFile storePicture;
  final String storeCountry;
  final String storeLocality;
  final String storeStreet;
  final String storePostalCode;
  final String storeNumberPort;

  RegisterStoreRequest(
    this.storePicture,
    this.storeCountry,
    this.storeLocality,
    this.storeStreet,
    this.storePostalCode,
    this.storeNumberPort,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'avatarPicture': storePicture,
      'country': storeCountry,
      'locality': storeLocality,
      'street': storeStreet,
      'postalCode': storePostalCode,
      'numberPort': storeNumberPort,
    };
  }
}
