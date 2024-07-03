import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterStoreRequest implements BaseMultiPartRequest {
  final XFile storePicture;
  final String storeName;
  final String storeCountry;
  final String storeLocality;
  final String storeStreet;
  final String storePostalCode;
  final String storeNumberPort;
  final double lat;
  final double lon;

  RegisterStoreRequest(
    this.storePicture,
    this.storeName,
    this.storeCountry,
    this.storeLocality,
    this.storeStreet,
    this.storePostalCode,
    this.storeNumberPort, {
    this.lat = 0.0,
    this.lon = 0.0,
  });

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'avatarPicture': storePicture,
      'name': storeName,
      'country': storeCountry,
      'locality': storeLocality,
      'street': storeStreet,
      'postalCode': storePostalCode,
      'numberPort': storeNumberPort,
      'lat': lat,
      'lon': lon,
    };
  }
}
