import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBrandRequest implements BaseJsonRequest {
  final String brandName;
  final XFile brandImage;

  RegisterBrandRequest(
    this.brandName,
    this.brandImage,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': brandName,
      // 'cloth_avatar': brandImage,
    };
  }
}
