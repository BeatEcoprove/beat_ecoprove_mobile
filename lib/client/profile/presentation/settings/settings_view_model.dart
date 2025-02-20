import 'package:beat_ecoprove/client/profile/domain/value_objects/language.dart';
import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/language_provider.dart';

class SettingsViewModel extends FormViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  final LanguageProvider _languageProvider;
  late final User? _user;

  SettingsViewModel(
    this._authProvider,
    this._navigationRouter,
    this._languageProvider,
  ) {
    _user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.language,
    ]);

    setValue(
      FormFieldValues.language,
      Language.getOf(_languageProvider.currentLocale.toString()),
    );
  }

  User? get user => _user;

  void changeLanguage(String value) {
    setValue(FormFieldValues.language, Language.getOfDisplayValue(value));
    _languageProvider.changeLanguage(Language.getOfDisplayValue(value).value);
  }

  Future logout() async {
    await _authProvider.logout();
  }

  void sendFeedback() {
    _navigationRouter.push(ProfileRoutes.feedback);
  }
}
