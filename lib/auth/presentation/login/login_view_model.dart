import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends FormViewModel {
  final LoginUseCase _loginUseCase;
  final GoRouter _navigationRouter;

  LoginViewModel(this._loginUseCase, this._navigationRouter) {
    initializeFields([FormFieldValues.email, FormFieldValues.password]);
  }

  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setEmail(String email) {
    try {
      setValue(FormFieldValues.email, Email.create(email).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.email, e.message);
    }
  }

  void setPassword(String password) {
    try {
      setValue(FormFieldValues.password, Password.create(password).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.password, e.message);
    }
  }

  void handleLogin() async {
    var email = getValue(FormFieldValues.email).value ?? "";
    var password = getValue(FormFieldValues.password).value ?? "";

    setLoading(true);

    try {
      await _loginUseCase.handle(LoginRequest(email, password));

      _navigationRouter.go("/");
    } catch (e) {
      print("$e");
    }

    setLoading(false);
    notifyListeners();
  }
}
