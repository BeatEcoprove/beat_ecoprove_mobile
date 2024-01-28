import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';

class UpdateGroupRequest implements BaseMultiPartRequest {
  final String adminId;
  final String groupId;
  final String groupName;
  final String groupDescription;
  final String groupIsPublic;
  final XFile groupPicture;

  UpdateGroupRequest(
    this.adminId,
    this.groupId,
    this.groupName,
    this.groupDescription,
    this.groupIsPublic,
    this.groupPicture,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': groupName,
      'description': groupDescription,
      'isPublic': groupIsPublic == "Público" ? "true" : "false",
      'avatarPicture': groupPicture,
    };
  }
}
