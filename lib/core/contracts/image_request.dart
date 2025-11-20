import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class ImageRequest implements BaseMultiPartRequest {
  final XFile image;
  final String type = "profile";

  ImageRequest(
    this.image,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      "image": image,
      "bucket": type,
    };
  }
}
