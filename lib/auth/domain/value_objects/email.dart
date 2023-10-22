import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class Email {
  static final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  final String value;

  Email._(this.value);
  factory Email.create(String email) {
    if (email.isEmpty) {
      throw DomainException("Porfavor introduza o email");
    }

    if (!emailRegex.hasMatch(email)) {
      throw DomainException("O email não é valido");
    }

    return Email._(email);
  }

  @override
  String toString() {
    return value;
  }
}
