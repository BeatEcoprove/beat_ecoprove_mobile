import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_strategy/sign_in_strategy.dart';

class SignInRequest implements BaseMultiPartRequest {
  final String email;
  final String password;
  final String role;
  final SignInStratagy strategy;

  SignInRequest({
    required this.email,
    required this.password,
    required this.role,
    required this.strategy,
  });

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
