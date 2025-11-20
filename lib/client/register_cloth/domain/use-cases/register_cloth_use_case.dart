import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/contracts/image_request.dart';
import 'package:beat_ecoprove/core/contracts/image_result.dart';
import 'package:beat_ecoprove/core/services/upload_image_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/register_cloth_request.dart';

class RegisterClothUseCase implements UseCase<RegisterClothRequest, Future> {
  final ClosetService _closetService;
  final UploadImageService _uploadImageService;

  RegisterClothUseCase(this._closetService, this._uploadImageService);

  @override
  Future<ClothResult> handle(RegisterClothRequest request) async {
    try {
      ImageResult result =
          await _uploadImageService.upload(ImageRequest(request.clothImage));

      request.picture = result.httpUrl;

      return await _closetService.registerCloth(request);
    } catch (e) {
      rethrow;
    }
  }
}
