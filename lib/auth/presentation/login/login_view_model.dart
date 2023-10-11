import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  handleLogin() async {
    try {
      await _loginUseCase
          .handle(LoginRequest("diogoassuncao@ipvc.pt", "password"));
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
