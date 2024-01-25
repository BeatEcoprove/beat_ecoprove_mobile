import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/password.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/promote_profile_use_case.dart';
import 'package:go_router/go_router.dart';

class ParamsProfileViewModel extends FormViewModel {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;
  final PromoteProfileUseCase _promoteProfileUseCase;
  final GoRouter _navigationRouter;
  late final User _user;
  late ProfilesResult _profilesResult;

  ParamsProfileViewModel(
    this._authProvider,
    this._authenticationService,
    this._navigationRouter,
    this._promoteProfileUseCase,
  ) {
    _user = _authProvider.appUser;
    _profilesResult = ProfilesResult.empty();
    initializeFields([
      FormFieldValues.email,
      FormFieldValues.password,
      FormFieldValues.confirmPassword
    ]);
  }

  Future<void> setEmail(String email) async {
    email = email.trim();

    try {
      bool isValid = await _authenticationService
          .validateFields(ValidateFieldRequest("email", email));

      if (!isValid) {
        setError(
            FormFieldValues.email, "O e-mail já é utilizado por um utilizador");
        return;
      }
    } on HttpError {
      return;
    }

    try {
      setValue<String>(FormFieldValues.email, Email.create(email).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.email, e.message);
    }
  }

  void setPassword(String password) {
    var confirmPassword = getValue(FormFieldValues.confirmPassword).value ?? "";

    if (password != confirmPassword) {
      setError(FormFieldValues.password, "As palavras-chaves devem ser iguais");
      setError(FormFieldValues.confirmPassword,
          "As palavras-chaves devem ser iguais");
    }

    try {
      setValue<String>(
          FormFieldValues.password, Password.create(password).toString());
      if (password == confirmPassword) {
        clearErrors(FormFieldValues.confirmPassword);
      }
    } on DomainException catch (e) {
      setError(FormFieldValues.password, e.message);
    }
  }

  void setConfirmPassword(String confirmPassword) {
    var password = getValue(FormFieldValues.password).value ?? "";

    if (password != confirmPassword) {
      setError(FormFieldValues.password, "As palavras-chaves devem ser iguais");
      setError(FormFieldValues.confirmPassword,
          "As palavras-chaves devem ser iguais");
    }

    try {
      setValue<String>(FormFieldValues.confirmPassword,
          Password.create(confirmPassword).toString());

      if (password == confirmPassword) clearErrors(FormFieldValues.password);
    } on DomainException catch (e) {
      setError(FormFieldValues.confirmPassword, e.message);
    }
  }

  User get user => _user;
  ProfilesResult get profilesResult => _profilesResult;

  Future<void> promoteProfile(String profileId) async {
    try {
      var email = getValue(FormFieldValues.email).value ?? "";
      var password = getValue(FormFieldValues.password).value ?? "";

      await _promoteProfileUseCase.handle(PromoteProfileRequest(
        email,
        password,
        profileId,
      ));

      _navigationRouter.pop();
      _navigationRouter.push("/show_completed",
          extra: ShowCompletedViewParams(
            text: "Uma conta com este perfil foi criada com sucesso!",
            textButton: "Continuar",
            action: () => _navigationRouter.pop(),
          ));
    } catch (e) {
      print("$e");
    }
  }
}
