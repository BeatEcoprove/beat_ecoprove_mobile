import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterClothRequest implements BaseJsonRequest {
  final String clothName;
  final String clothType;
  final String clothSize;
  final String clothBrand;
  final String clothColor;
  final XFile clothImage;

  RegisterClothRequest(
    this.clothName,
    this.clothType,
    this.clothSize,
    this.clothBrand,
    this.clothColor,
    this.clothImage,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': clothName,
      'cloth_type': clothType,
      'cloth_size': clothSize,
      'brand': clothBrand,
      'color': clothColor,
      //FIXME: Uncomment when backend is ready
      // 'cloth_avatar': clothImage,
    };
  }
}
