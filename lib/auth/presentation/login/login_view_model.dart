import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/validators/email_validator.dart';
import 'package:beat_ecoprove/auth/validators/password_validator.dart';
import 'package:beat_ecoprove/auth/validators/validation_exception.dart';
import 'package:beat_ecoprove/auth/validators/validator.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class LoginViewModel extends ViewModel {
  final Validator _emailValidator = EmailValidator();
  final Validator _passwordValidator = PasswordValidator();
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  final List<String> _error = List.filled(2, "");
  late String _email = "";
  late String _password = "";
  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get emailError => _error[0];
  String get passwordError => _error[1];

  void cleanError(int index) {
    _error[index] = "";
  }

  void setError(String message, int index) {
    _error[index] = message;
  }

  String get email => _email;

  setEmail(String email) {
    try {
      _emailValidator.validate(email);
      cleanError(0);
    } on ValidationException catch (e) {
      setError(e.message, 0);
    }

    _email = email;
    notifyListeners();
  }

  String get password => _password;

  setPassword(String password) {
    try {
      _passwordValidator.validate(password);
      cleanError(1);
    } on ValidationException catch (e) {
      setError(e.message, 1);
    }

    notifyListeners();
    _password = password;
  }

  bool get canHandleLogin {
    if (_password.isEmpty || _email.isEmpty) {
      return false;
    }

    try {
      _passwordValidator.validate(_password);
      _emailValidator.validate(_email);
    } on ValidationException catch (_) {
      return false;
    }

    return true;
  }

  handleLogin() async {
    setLoading(true);

    await _loginUseCase.handle(LoginRequest(_email, _password));

    setLoading(false);
    notifyListeners();
  }
}
