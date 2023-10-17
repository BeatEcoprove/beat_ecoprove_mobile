import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';

class AuthUserModel {
  late String name;
  late DateTime bornDate;
  late Gender gender;
  late String userName;
  late Uri avatarUrl;
  late String email;
  late String password;
  late Address address;
  late Phone phone;

  AuthUserModel({
    required this.name,
    required this.bornDate,
    required this.gender,
    required this.userName,
    required this.avatarUrl,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,
  });
}
