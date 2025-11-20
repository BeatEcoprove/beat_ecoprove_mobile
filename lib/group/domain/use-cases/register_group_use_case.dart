import 'package:beat_ecoprove/core/contracts/image_request.dart';
import 'package:beat_ecoprove/core/contracts/image_result.dart';
import 'package:beat_ecoprove/core/services/upload_image_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class RegisterGroupUseCase implements UseCase<RegisterGroupRequest, Future> {
  final GroupService _groupService;
  final UploadImageService _uploadImageService;

  RegisterGroupUseCase(this._groupService, this._uploadImageService);

  @override
  Future handle(RegisterGroupRequest request) async {
    try {
      ImageResult result =
          await _uploadImageService.upload(ImageRequest(request.groupPicture));

      request.picture = result.httpUrl;

      await _groupService.registerGroup(request);
    } catch (e) {
      rethrow;
    }
  }
}
