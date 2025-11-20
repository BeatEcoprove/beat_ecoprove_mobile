import 'package:beat_ecoprove/client/clothing/contracts/register_brand_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/contracts/image_request.dart';
import 'package:beat_ecoprove/core/contracts/image_result.dart';
import 'package:beat_ecoprove/core/services/upload_image_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class CreateBrandUseCase implements UseCase<RegisterBrandRequest, Future> {
  final ClosetService _closetService;
  final UploadImageService _uploadImageService;

  CreateBrandUseCase(this._closetService, this._uploadImageService);

  @override
  Future<void> handle(RegisterBrandRequest request) async {
    try {
      ImageResult result =
          await _uploadImageService.upload(ImageRequest(request.brandImage));

      request.picture = result.httpUrl;

      await _closetService.registerBrand(request);
    } catch (e) {
      rethrow;
    }
  }
}
