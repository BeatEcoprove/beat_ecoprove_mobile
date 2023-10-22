import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';

class SignInEnterpriseRequest {
  final String name;
  final String typeOption;
  final Phone phone;
  final String country;
  final Address address;
  final String userName;
  final Uri image;
  final String email;
  final String password;

  SignInEnterpriseRequest({
    required this.name,
    required this.typeOption,
    required this.phone,
    required this.country,
    required this.address,
    required this.userName,
    required this.image,
    required this.email,
    required this.password,
  });
}
