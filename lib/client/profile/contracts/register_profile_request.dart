import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterProfileRequest implements BaseMultiPartRequest {
  final String profileName;
  final DateTime profileBornDate;
  final Gender profileGender;
  final XFile profilePicture;
  final String profileUserName;

  RegisterProfileRequest(
    this.profileName,
    this.profileBornDate,
    this.profileGender,
    this.profilePicture,
    this.profileUserName,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': profileName,
      'bornDate': DateFormat('yyyy-MM-dd').format(profileBornDate),
      'gender': profileGender.value,
      'avatar': profilePicture,
      'userName': profileUserName,
    };
  }
}
