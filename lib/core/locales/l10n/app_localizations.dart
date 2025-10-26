import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @auth_login_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get auth_login_email;

  /// No description provided for @auth_login_password.
  ///
  /// In en, this message translates to:
  /// **'Palavra-chave'**
  String get auth_login_password;

  /// No description provided for @auth_login_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Esqueceu-se da Palavra-chave?'**
  String get auth_login_forgot_password;

  /// No description provided for @auth_login_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Entrar'**
  String get auth_login_sign_in;

  /// No description provided for @auth_login_got_no_account.
  ///
  /// In en, this message translates to:
  /// **'Não tem Conta?'**
  String get auth_login_got_no_account;

  /// No description provided for @auth_login_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Registar'**
  String get auth_login_sign_up;

  /// No description provided for @auth_select_user_type.
  ///
  /// In en, this message translates to:
  /// **'Selecione o Tipo de Utilizador'**
  String get auth_select_user_type;

  /// No description provided for @auth_select_user_personal_type.
  ///
  /// In en, this message translates to:
  /// **'Pessoal'**
  String get auth_select_user_personal_type;

  /// No description provided for @auth_select_user_enterprise_type.
  ///
  /// In en, this message translates to:
  /// **'Empresa'**
  String get auth_select_user_enterprise_type;

  /// No description provided for @auth_select_user_finish.
  ///
  /// In en, this message translates to:
  /// **'Continuar'**
  String get auth_select_user_finish;

  /// No description provided for @auth_sign_in_sucess.
  ///
  /// In en, this message translates to:
  /// **'Conta criada com sucesso'**
  String get auth_sign_in_sucess;

  /// No description provided for @auth_sign_in_enter.
  ///
  /// In en, this message translates to:
  /// **'Entrar'**
  String get auth_sign_in_enter;

  /// No description provided for @auth_personal_info.
  ///
  /// In en, this message translates to:
  /// **'Informações Pessoais'**
  String get auth_personal_info;

  /// No description provided for @auth_personal_name.
  ///
  /// In en, this message translates to:
  /// **'Nome'**
  String get auth_personal_name;

  /// No description provided for @auth_personal_birth_date.
  ///
  /// In en, this message translates to:
  /// **'Data de Nascimento'**
  String get auth_personal_birth_date;

  /// No description provided for @auth_personal_phone.
  ///
  /// In en, this message translates to:
  /// **'Telemóvel'**
  String get auth_personal_phone;

  /// No description provided for @auth_personal_finish.
  ///
  /// In en, this message translates to:
  /// **'Concluir'**
  String get auth_personal_finish;

  /// No description provided for @auth_personal_insert_first_name_after_the_second.
  ///
  /// In en, this message translates to:
  /// **'Insira o seu primeiro e segundo nome separado por um espaço.'**
  String get auth_personal_insert_first_name_after_the_second;

  /// No description provided for @auth_enterprise_service_provider_info.
  ///
  /// In en, this message translates to:
  /// **'Informações Do Prestador de Serviço'**
  String get auth_enterprise_service_provider_info;

  /// No description provided for @auth_enterprise_service_provider_laundry.
  ///
  /// In en, this message translates to:
  /// **'Lavandaria'**
  String get auth_enterprise_service_provider_laundry;

  /// No description provided for @auth_enterprise_service_provider_repair.
  ///
  /// In en, this message translates to:
  /// **'Reparação'**
  String get auth_enterprise_service_provider_repair;

  /// No description provided for @auth_enterprise_address.
  ///
  /// In en, this message translates to:
  /// **'Morada'**
  String get auth_enterprise_address;

  /// No description provided for @auth_enterprise_street.
  ///
  /// In en, this message translates to:
  /// **'Rua'**
  String get auth_enterprise_street;

  /// No description provided for @auth_enterprise_zip_code.
  ///
  /// In en, this message translates to:
  /// **'Código Postal'**
  String get auth_enterprise_zip_code;

  /// No description provided for @auth_enterprise_port.
  ///
  /// In en, this message translates to:
  /// **'Porta'**
  String get auth_enterprise_port;

  /// No description provided for @auth_enterprise_insert_street.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza a rua da sua sede'**
  String get auth_enterprise_insert_street;

  /// No description provided for @auth_enterprise_insert_zip_code.
  ///
  /// In en, this message translates to:
  /// **'Introduza um codigo postal'**
  String get auth_enterprise_insert_zip_code;

  /// No description provided for @auth_enterprise_insert_port.
  ///
  /// In en, this message translates to:
  /// **'Introduza uma porta'**
  String get auth_enterprise_insert_port;

  /// No description provided for @auth_enterprise_insert_an_valid_port.
  ///
  /// In en, this message translates to:
  /// **'Introduza um porta válida'**
  String get auth_enterprise_insert_an_valid_port;

  /// No description provided for @auth_avatar_avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get auth_avatar_avatar;

  /// No description provided for @auth_avatar_username.
  ///
  /// In en, this message translates to:
  /// **'Nome de exibição'**
  String get auth_avatar_username;

  /// No description provided for @auth_avatar_finish.
  ///
  /// In en, this message translates to:
  /// **'Continuar'**
  String get auth_avatar_finish;

  /// No description provided for @auth_avatar_user_already_exists.
  ///
  /// In en, this message translates to:
  /// **'O nome de utilizador já existe'**
  String get auth_avatar_user_already_exists;

  /// No description provided for @auth_final_stage_account.
  ///
  /// In en, this message translates to:
  /// **'Conta'**
  String get auth_final_stage_account;

  /// No description provided for @auth_final_stage_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get auth_final_stage_email;

  /// No description provided for @auth_final_stage_password.
  ///
  /// In en, this message translates to:
  /// **'Palavra-Chave'**
  String get auth_final_stage_password;

  /// No description provided for @auth_final_stage_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirmar palavra-chave'**
  String get auth_final_stage_confirm_password;

  /// No description provided for @auth_final_stage_finish.
  ///
  /// In en, this message translates to:
  /// **'Concluir'**
  String get auth_final_stage_finish;

  /// No description provided for @auth_final_stage_email_already_used.
  ///
  /// In en, this message translates to:
  /// **'O e-mail já é utilizado por um utilizador'**
  String get auth_final_stage_email_already_used;

  /// No description provided for @auth_final_stage_password_must_be_the_same.
  ///
  /// In en, this message translates to:
  /// **'As palavras-chaves devem ser iguais'**
  String get auth_final_stage_password_must_be_the_same;

  /// No description provided for @auth_code_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Introduza o código'**
  String get auth_code_is_empty;

  /// No description provided for @auth_code_should_have_6_digits.
  ///
  /// In en, this message translates to:
  /// **'O código deve ter 6 digitos'**
  String get auth_code_should_have_6_digits;

  /// No description provided for @auth_email_insert_pls.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza o email'**
  String get auth_email_insert_pls;

  /// No description provided for @auth_email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'O email não é valido'**
  String get auth_email_not_valid;

  /// No description provided for @auth_name_insert_first_name.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza o seu primeiro nome'**
  String get auth_name_insert_first_name;

  /// No description provided for @auth_name_insert_last_name.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza o seu último nome'**
  String get auth_name_insert_last_name;

  /// No description provided for @auth_name_insert_only_first_and_last.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza apenas o seu primeiro e último nome'**
  String get auth_name_insert_only_first_and_last;

  /// No description provided for @auth_password_btw_6_16.
  ///
  /// In en, this message translates to:
  /// **'A palavra-chave deve ter entre 6 a 16 caracteres'**
  String get auth_password_btw_6_16;

  /// No description provided for @auth_password_must_insert.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza a palavra-chave'**
  String get auth_password_must_insert;

  /// No description provided for @auth_password_at_least_one_number.
  ///
  /// In en, this message translates to:
  /// **'A palavra-chave deve conter pelo menos 1 número'**
  String get auth_password_at_least_one_number;

  /// No description provided for @auth_password_should_have_at_lest_one_letter.
  ///
  /// In en, this message translates to:
  /// **'A palavra-chave deve conter pelo menos um letra maiúscula'**
  String get auth_password_should_have_at_lest_one_letter;

  /// No description provided for @auth_password_at_lest_one_caps.
  ///
  /// In en, this message translates to:
  /// **'A palavra-chave deve conter pelo menos um letra minúscula'**
  String get auth_password_at_lest_one_caps;

  /// No description provided for @auth_phone_must_9_numbers.
  ///
  /// In en, this message translates to:
  /// **'O telefone deve ter 9 números'**
  String get auth_phone_must_9_numbers;

  /// No description provided for @auth_zip_code_must_7_numbers.
  ///
  /// In en, this message translates to:
  /// **'O código postal deve ter 7 números'**
  String get auth_zip_code_must_7_numbers;

  /// No description provided for @auth_username_insert_it.
  ///
  /// In en, this message translates to:
  /// **'Por favor introduza um nome de utilizador'**
  String get auth_username_insert_it;

  /// No description provided for @client_register_cloth_created.
  ///
  /// In en, this message translates to:
  /// **'Peça criada!'**
  String get client_register_cloth_created;

  /// No description provided for @client_register_register_cloth.
  ///
  /// In en, this message translates to:
  /// **'Registar Peça'**
  String get client_register_register_cloth;

  /// No description provided for @client_register_imagem.
  ///
  /// In en, this message translates to:
  /// **'Imagem'**
  String get client_register_imagem;

  /// No description provided for @client_register_name.
  ///
  /// In en, this message translates to:
  /// **'Nome'**
  String get client_register_name;

  /// No description provided for @client_register_color.
  ///
  /// In en, this message translates to:
  /// **'Cor'**
  String get client_register_color;

  /// No description provided for @client_register_register.
  ///
  /// In en, this message translates to:
  /// **'Registar'**
  String get client_register_register;

  /// No description provided for @client_register_qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get client_register_qr_code;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
