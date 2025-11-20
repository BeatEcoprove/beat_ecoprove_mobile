import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBrandRequest implements BaseJsonRequest {
  final String brandName;
  final XFile brandImage;
  late String? picture;

  RegisterBrandRequest(this.brandName, this.brandImage, {this.picture});

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': brandName,
      'picture': picture,
    };
  }
}
