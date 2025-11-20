import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/group/domain/value_objects/group_type.dart';
import 'package:image_picker/image_picker.dart';

class RegisterGroupRequest implements BaseJsonRequest {
  final String groupName;
  final String groupDescription;
  final GroupType groupIsPublic;
  final XFile groupPicture;
  late String? picture;

  RegisterGroupRequest(
    this.groupName,
    this.groupDescription,
    this.groupIsPublic,
    this.groupPicture,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': groupName,
      'description': groupDescription,
      'is_public': groupIsPublic == GroupType.public ? "true" : "false",
      'picture': picture,
    };
  }
}
