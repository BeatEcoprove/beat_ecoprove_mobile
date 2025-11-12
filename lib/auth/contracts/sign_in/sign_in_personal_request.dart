import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:intl/intl.dart';

class SignInPersonalRequest implements BaseJsonRequest {
  final String profileId;
  final String firstName;
  final String lastName;
  final String displayName;
  final DateTime birthDate;
  final Gender gender;
  final Phone phone;

  SignInPersonalRequest({
    required this.profileId,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.birthDate,
    required this.gender,
    required this.phone,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'birth_date': DateFormat('yyyy-MM-dd').format(birthDate),
      'biography': '',
      'gender': gender.value,
      'phone_number': phone.countryCode + phone.value.replaceAll(" ", ""),
    };
  }
}
