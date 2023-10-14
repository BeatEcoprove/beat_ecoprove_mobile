import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  late String _email;
  late String _password;

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  handleLogin() async {
    if (checkEmailAndPasswordLength) {
      return;
    }

    try {
      await _loginUseCase.handle(LoginRequest(_email, _password));
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  bool get checkEmailAndPasswordLength => _email.isEmpty && _password.isEmpty;

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
