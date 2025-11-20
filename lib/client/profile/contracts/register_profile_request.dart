import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProfileRequest {
  final String profileName;
  final DateTime profileBirthDate;
  final Gender profileGender;
  final XFile profilePicture;
  final String profileUserName;
  late String? picture;

  RegisterProfileRequest(
    this.profileName,
    this.profileBirthDate,
    this.profileGender,
    this.profilePicture,
    this.profileUserName,
  );
}
