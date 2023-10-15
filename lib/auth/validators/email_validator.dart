import 'package:beat_ecoprove/auth/validators/validation_exception.dart';
import 'package:beat_ecoprove/auth/validators/validator.dart';

class EmailValidator implements Validator<String> {
  static const emailValidationMessage = "O email não é valido";

  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  @override
  bool validate(email) {
    if (!emailRegex.hasMatch(email)) {
      throw ValidationException(emailValidationMessage);
    }

    return true;
  }
}
