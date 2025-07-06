import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBrandRequest implements BaseMultiPartRequest {
  final String brandName;
  final XFile brandImage;

  RegisterBrandRequest(
    this.brandName,
    this.brandImage,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': brandName,
      'clothAvatar': brandImage,
    };
  }
}
