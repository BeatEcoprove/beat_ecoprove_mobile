import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:image_picker/image_picker.dart';

class SignInEnterpriseRequest implements BaseMultiPartRequest {
  final String name;
  final String typeOption;
  final Phone phone;
  final String country;
  final Address address;
  final String userName;
  final XFile avatarUrl;
  final String email;
  final String password;

  SignInEnterpriseRequest({
    required this.name,
    required this.typeOption,
    required this.phone,
    required this.country,
    required this.address,
    required this.userName,
    required this.avatarUrl,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'name': name,
      'typeOption': typeOption,
      'countryCode': phone.countryCode,
      'phone': phone.value.replaceAll(" ", ""),
      'country': country,
      'street': address.street,
      'port': address.port.toString(),
      'locality': address.locality,
      'postalCode': address.postalCode.toString(),
      'userName': userName,
      'avatarPicture': avatarUrl,
      'email': email,
      'password': password,
    };
  }
}
