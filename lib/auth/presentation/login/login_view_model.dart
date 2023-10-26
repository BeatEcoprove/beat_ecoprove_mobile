import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';

class LoginViewModel extends FormViewModel {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) {
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

    await _loginUseCase.handle(LoginRequest(email, password));

    setLoading(false);
    notifyListeners();
  }
}
