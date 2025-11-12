import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';

class SignInEnterpriseRequest implements BaseJsonRequest {
  final String profileId;
  final String firstName;
  final String lastName;
  final String displayName;
  final Phone phone;
  final Address address;
  final String country;

  SignInEnterpriseRequest({
    required this.profileId,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.phone,
    required this.country,
    required this.address,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'biography': '',
      'phone_number': phone.countryCode + phone.value.replaceAll(" ", ""),
      'street': address.street,
      'country': country,
      'locality': address.locality,
      'port': address.port.toString(),
      'zip_code': address.postalCode.toString(),
    };
  }
}
