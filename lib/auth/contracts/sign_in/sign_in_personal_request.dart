import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignInPersonalRequest implements BaseMultiPartRequest {
  final String name;
  final DateTime bornDate;
  final Gender gender;
  final String userName;
  final XFile avatarPicture;
  final String email;
  final String password;
  final Phone phone;

  SignInPersonalRequest({
    required this.name,
    required this.bornDate,
    required this.gender,
    required this.userName,
    required this.avatarPicture,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': name,
      'bornDate': DateFormat('yyyy-MM-dd').format(bornDate),
      'gender': gender.value,
      'userName': userName,
      'avatarPicture': avatarPicture,
      'email': email,
      'password': password,
      'countryCode': phone.countryCode,
      'phone': phone.value.replaceAll(" ", ""),
    };
  }
}
