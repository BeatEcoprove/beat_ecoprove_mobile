import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterClothRequest implements BaseMultiPartRequest {
  final String profileId;
  final String clothName;
  final String clothType;
  final String clothSize;
  final String clothBrand;
  final String clothColor;
  final XFile clothImage;

  RegisterClothRequest(
    this.profileId,
    this.clothName,
    this.clothType,
    this.clothSize,
    this.clothBrand,
    this.clothColor,
    this.clothImage,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': clothName,
      'garmentType': clothType,
      'garmentSize': clothSize,
      'brand': clothBrand,
      'color': clothColor,
      'clothAvatar': clothImage,
    };
  }
}
