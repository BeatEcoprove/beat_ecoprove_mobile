import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';

class SignInPersonalRequest {
  final String name;
  final String bornDate;
  final String gender;
  final String userName;
  final Uri avatarUrl;
  final String email;
  final String password;
  final Phone phone;

  SignInPersonalRequest(
      {required this.name,
      required this.bornDate,
      required this.gender,
      required this.userName,
      required this.avatarUrl,
      required this.email,
      required this.password,
      required this.phone});
}
