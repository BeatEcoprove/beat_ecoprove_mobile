import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
  /// **'Password'**
  String get auth_login_password;

  /// No description provided for @auth_login_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get auth_login_forgot_password;

  /// No description provided for @auth_login_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get auth_login_sign_in;

  /// No description provided for @auth_login_got_no_account.
  ///
  /// In en, this message translates to:
  /// **'No Account?'**
  String get auth_login_got_no_account;

  /// No description provided for @auth_login_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_login_sign_up;

  /// No description provided for @auth_select_user_type.
  ///
  /// In en, this message translates to:
  /// **'Select User Type'**
  String get auth_select_user_type;

  /// No description provided for @auth_select_user_personal_type.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get auth_select_user_personal_type;

  /// No description provided for @auth_select_user_enterprise_type.
  ///
  /// In en, this message translates to:
  /// **'Enterprise'**
  String get auth_select_user_enterprise_type;

  /// No description provided for @auth_select_user_finish.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_select_user_finish;

  /// No description provided for @auth_sign_in_sucess.
  ///
  /// In en, this message translates to:
  /// **'Account successfully created'**
  String get auth_sign_in_sucess;

  /// No description provided for @auth_sign_in_enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get auth_sign_in_enter;

  /// No description provided for @auth_personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get auth_personal_info;

  /// No description provided for @auth_personal_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get auth_personal_name;

  /// No description provided for @auth_personal_birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get auth_personal_birth_date;

  /// No description provided for @auth_personal_phone.
  ///
  /// In en, this message translates to:
  /// **'Mobile phone'**
  String get auth_personal_phone;

  /// No description provided for @auth_personal_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get auth_personal_finish;

  /// No description provided for @auth_personal_insert_first_name_after_the_second.
  ///
  /// In en, this message translates to:
  /// **'Enter your first and second name separated by a space.'**
  String get auth_personal_insert_first_name_after_the_second;

  /// No description provided for @auth_enterprise_service_provider_info.
  ///
  /// In en, this message translates to:
  /// **'Service Provider Information'**
  String get auth_enterprise_service_provider_info;

  /// No description provided for @auth_enterprise_service_provider_laundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry'**
  String get auth_enterprise_service_provider_laundry;

  /// No description provided for @auth_enterprise_service_provider_repair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get auth_enterprise_service_provider_repair;

  /// No description provided for @auth_enterprise_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get auth_enterprise_address;

  /// No description provided for @auth_enterprise_street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get auth_enterprise_street;

  /// No description provided for @auth_enterprise_zip_code.
  ///
  /// In en, this message translates to:
  /// **'ZIP code'**
  String get auth_enterprise_zip_code;

  /// No description provided for @auth_enterprise_port.
  ///
  /// In en, this message translates to:
  /// **'Door Number'**
  String get auth_enterprise_port;

  /// No description provided for @auth_enterprise_insert_street.
  ///
  /// In en, this message translates to:
  /// **'Please enter the street of your headquarters'**
  String get auth_enterprise_insert_street;

  /// No description provided for @auth_enterprise_insert_zip_code.
  ///
  /// In en, this message translates to:
  /// **'Enter a zip code'**
  String get auth_enterprise_insert_zip_code;

  /// No description provided for @auth_enterprise_insert_port.
  ///
  /// In en, this message translates to:
  /// **'Insert a door number'**
  String get auth_enterprise_insert_port;

  /// No description provided for @auth_enterprise_insert_an_valid_port.
  ///
  /// In en, this message translates to:
  /// **'Insert a valid door number'**
  String get auth_enterprise_insert_an_valid_port;

  /// No description provided for @auth_avatar_avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get auth_avatar_avatar;

  /// No description provided for @auth_avatar_username.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get auth_avatar_username;

  /// No description provided for @auth_avatar_finish.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_avatar_finish;

  /// No description provided for @auth_avatar_user_already_exists.
  ///
  /// In en, this message translates to:
  /// **'The username already exists'**
  String get auth_avatar_user_already_exists;

  /// No description provided for @auth_final_stage_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get auth_final_stage_account;

  /// No description provided for @auth_final_stage_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get auth_final_stage_email;

  /// No description provided for @auth_final_stage_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_final_stage_password;

  /// No description provided for @auth_final_stage_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get auth_final_stage_confirm_password;

  /// No description provided for @auth_final_stage_finish.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_final_stage_finish;

  /// No description provided for @auth_final_stage_email_already_used.
  ///
  /// In en, this message translates to:
  /// **'The e-mail is already used by a user'**
  String get auth_final_stage_email_already_used;

  /// No description provided for @auth_final_stage_password_must_be_the_same.
  ///
  /// In en, this message translates to:
  /// **'The passwords must be the same'**
  String get auth_final_stage_password_must_be_the_same;

  /// No description provided for @auth_code_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get auth_code_is_empty;

  /// No description provided for @auth_code_should_have_6_digits.
  ///
  /// In en, this message translates to:
  /// **'The code must have 6 digits'**
  String get auth_code_should_have_6_digits;

  /// No description provided for @auth_email_insert_pls.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get auth_email_insert_pls;

  /// No description provided for @auth_email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'The email address is invalid'**
  String get auth_email_not_valid;

  /// No description provided for @auth_name_insert_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get auth_name_insert_first_name;

  /// No description provided for @auth_name_insert_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get auth_name_insert_last_name;

  /// No description provided for @auth_name_insert_only_first_and_last.
  ///
  /// In en, this message translates to:
  /// **'Please only enter your first and last name'**
  String get auth_name_insert_only_first_and_last;

  /// No description provided for @auth_password_btw_8_16.
  ///
  /// In en, this message translates to:
  /// **'The password must be between 8 and 16 characters long'**
  String get auth_password_btw_8_16;

  /// No description provided for @auth_password_must_insert.
  ///
  /// In en, this message translates to:
  /// **'Please enter the password'**
  String get auth_password_must_insert;

  /// No description provided for @auth_password_at_least_one_number.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one number'**
  String get auth_password_at_least_one_number;

  /// No description provided for @auth_password_should_have_at_lest_one_letter.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one capital letter'**
  String get auth_password_should_have_at_lest_one_letter;

  /// No description provided for @auth_password_at_lest_one_caps.
  ///
  /// In en, this message translates to:
  /// **'The password must contain at least one lowercase letter'**
  String get auth_password_at_lest_one_caps;

  /// No description provided for @auth_phone_must_9_numbers.
  ///
  /// In en, this message translates to:
  /// **'The phone number must have 9 numbers'**
  String get auth_phone_must_9_numbers;

  /// No description provided for @auth_zip_code_must_7_numbers.
  ///
  /// In en, this message translates to:
  /// **'The zip code must have 7 numbers'**
  String get auth_zip_code_must_7_numbers;

  /// No description provided for @auth_username_insert_it.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get auth_username_insert_it;

  /// No description provided for @client_register_cloth_add_brand.
  ///
  /// In en, this message translates to:
  /// **'Register Brand'**
  String get client_register_cloth_add_brand;

  /// No description provided for @client_register_cloth_created.
  ///
  /// In en, this message translates to:
  /// **'Garment created!'**
  String get client_register_cloth_created;

  /// No description provided for @client_register_register_cloth.
  ///
  /// In en, this message translates to:
  /// **'Register garment'**
  String get client_register_register_cloth;

  /// No description provided for @client_register_imagem.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get client_register_imagem;

  /// No description provided for @client_register_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get client_register_size;

  /// No description provided for @client_register_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get client_register_category;

  /// No description provided for @client_register_brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get client_register_brand;

  /// No description provided for @client_register_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get client_register_name;

  /// No description provided for @client_register_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get client_register_color;

  /// No description provided for @client_register_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get client_register_register;

  /// No description provided for @client_register_qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get client_register_qr_code;

  /// No description provided for @profile_settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_settings_language;

  /// No description provided for @auth_forgot_password_insert_code_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code'**
  String get auth_forgot_password_insert_code_error_empty;

  /// No description provided for @auth_forgot_password_insert_code_send_code.
  ///
  /// In en, this message translates to:
  /// **'A code has been sent to your email address'**
  String get auth_forgot_password_insert_code_send_code;

  /// No description provided for @auth_forgot_password_insert_code_insert_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your email'**
  String get auth_forgot_password_insert_code_insert_code;

  /// No description provided for @auth_forgot_password_insert_code_code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get auth_forgot_password_insert_code_code;

  /// No description provided for @auth_forgot_password_insert_code_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_forgot_password_insert_code_continue;

  /// No description provided for @auth_forgot_password_reset_password_equal_password.
  ///
  /// In en, this message translates to:
  /// **'The passwords must be the same'**
  String get auth_forgot_password_reset_password_equal_password;

  /// No description provided for @auth_forgot_password_reset_password_changed.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get auth_forgot_password_reset_password_changed;

  /// No description provided for @auth_forgot_password_reset_password_new_password.
  ///
  /// In en, this message translates to:
  /// **'Redefine your password'**
  String get auth_forgot_password_reset_password_new_password;

  /// No description provided for @auth_forgot_password_reset_password_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_forgot_password_reset_password_password;

  /// No description provided for @auth_forgot_password_reset_password_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get auth_forgot_password_reset_password_confirm_password;

  /// No description provided for @auth_forgot_password_reset_password_show_password.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get auth_forgot_password_reset_password_show_password;

  /// No description provided for @auth_forgot_password_reset_password_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_forgot_password_reset_password_continue;

  /// No description provided for @auth_login_error_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get auth_login_error_email;

  /// No description provided for @auth_login_email_check_part_1.
  ///
  /// In en, this message translates to:
  /// **'The user with the email '**
  String get auth_login_email_check_part_1;

  /// No description provided for @auth_login_email_check_part_2.
  ///
  /// In en, this message translates to:
  /// **' does not exist'**
  String get auth_login_email_check_part_2;

  /// No description provided for @auth_login_request_sended.
  ///
  /// In en, this message translates to:
  /// **'The request has been sent!'**
  String get auth_login_request_sended;

  /// No description provided for @auth_login_show_password.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get auth_login_show_password;

  /// No description provided for @auth_final_stage_finish_show_password.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get auth_final_stage_finish_show_password;

  /// No description provided for @client_clothing_contracts_current_service_finish_action.
  ///
  /// In en, this message translates to:
  /// **'Bring the action to a close'**
  String get client_clothing_contracts_current_service_finish_action;

  /// No description provided for @client_clothing_domain_data_filters_jeans.
  ///
  /// In en, this message translates to:
  /// **'Jeans'**
  String get client_clothing_domain_data_filters_jeans;

  /// No description provided for @client_clothing_domain_data_filters_jackets.
  ///
  /// In en, this message translates to:
  /// **'Jackets'**
  String get client_clothing_domain_data_filters_jackets;

  /// No description provided for @client_clothing_domain_data_filters_t_shirts.
  ///
  /// In en, this message translates to:
  /// **'T-shirts'**
  String get client_clothing_domain_data_filters_t_shirts;

  /// No description provided for @client_clothing_domain_data_filters_shirts.
  ///
  /// In en, this message translates to:
  /// **'Shirts'**
  String get client_clothing_domain_data_filters_shirts;

  /// No description provided for @client_clothing_domain_data_filters_skirts.
  ///
  /// In en, this message translates to:
  /// **'Skirts'**
  String get client_clothing_domain_data_filters_skirts;

  /// No description provided for @client_clothing_domain_data_filters_size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get client_clothing_domain_data_filters_size;

  /// No description provided for @client_clothing_domain_bucket_name_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name for the basket'**
  String get client_clothing_domain_bucket_name_empty;

  /// No description provided for @client_clothing_closet_clothing_state_updated.
  ///
  /// In en, this message translates to:
  /// **'Status updated!'**
  String get client_clothing_closet_clothing_state_updated;

  /// No description provided for @client_clothing_closet_clothing_removed.
  ///
  /// In en, this message translates to:
  /// **'Successfully removed!'**
  String get client_clothing_closet_clothing_removed;

  /// No description provided for @client_clothing_closet_clothing_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get client_clothing_closet_clothing_color;

  /// No description provided for @client_clothing_closet_clothing_brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get client_clothing_closet_clothing_brand;

  /// No description provided for @client_clothing_closet_clothing_profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get client_clothing_closet_clothing_profiles;

  /// No description provided for @client_clothing_closet_clothing_bucket_created.
  ///
  /// In en, this message translates to:
  /// **'Basket created!'**
  String get client_clothing_closet_clothing_bucket_created;

  /// No description provided for @client_clothing_closet_clothing_no_buckets.
  ///
  /// In en, this message translates to:
  /// **'There are no baskets!'**
  String get client_clothing_closet_clothing_no_buckets;

  /// No description provided for @client_clothing_closet_clothing_which_bucket.
  ///
  /// In en, this message translates to:
  /// **'Which basket do you want to put this garment in?'**
  String get client_clothing_closet_clothing_which_bucket;

  /// No description provided for @client_clothing_closet_clothing_garment_added_bucket.
  ///
  /// In en, this message translates to:
  /// **'Garment/s successfully added to basket!'**
  String get client_clothing_closet_clothing_garment_added_bucket;

  /// No description provided for @client_clothing_closet_clothing_bucket_name.
  ///
  /// In en, this message translates to:
  /// **'Basket name'**
  String get client_clothing_closet_clothing_bucket_name;

  /// No description provided for @client_clothing_closet_clothing_new_bucket.
  ///
  /// In en, this message translates to:
  /// **'New basket'**
  String get client_clothing_closet_clothing_new_bucket;

  /// No description provided for @client_clothing_closet_clothing_create_bucket.
  ///
  /// In en, this message translates to:
  /// **'Create basket'**
  String get client_clothing_closet_clothing_create_bucket;

  /// No description provided for @client_clothing_closet_clothing_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get client_clothing_closet_clothing_create;

  /// No description provided for @client_clothing_closet_clothing_closet.
  ///
  /// In en, this message translates to:
  /// **'Closet'**
  String get client_clothing_closet_clothing_closet;

  /// No description provided for @client_clothing_closet_clothing_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get client_clothing_closet_clothing_search;

  /// No description provided for @client_clothing_closet_clothing_no_garment.
  ///
  /// In en, this message translates to:
  /// **'There is no garment!'**
  String get client_clothing_closet_clothing_no_garment;

  /// No description provided for @client_clothing_info_card_bucket_change_name_updated.
  ///
  /// In en, this message translates to:
  /// **'Basket successfully updated!'**
  String get client_clothing_info_card_bucket_change_name_updated;

  /// No description provided for @client_clothing_info_card_bucket_change_name_alter_name.
  ///
  /// In en, this message translates to:
  /// **'Change basket name'**
  String get client_clothing_info_card_bucket_change_name_alter_name;

  /// No description provided for @client_clothing_info_card_bucket_change_name_name.
  ///
  /// In en, this message translates to:
  /// **'Basket name'**
  String get client_clothing_info_card_bucket_change_name_name;

  /// No description provided for @client_clothing_info_card_bucket_change_name_alter.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get client_clothing_info_card_bucket_change_name_alter;

  /// No description provided for @client_clothing_info_card_bucket_info_error_no_garments_selected.
  ///
  /// In en, this message translates to:
  /// **'There are no selected garments!'**
  String get client_clothing_info_card_bucket_info_error_no_garments_selected;

  /// No description provided for @client_clothing_info_card_bucket_info_garment_removed.
  ///
  /// In en, this message translates to:
  /// **'Garment/s successfully removed!'**
  String get client_clothing_info_card_bucket_info_garment_removed;

  /// No description provided for @client_clothing_info_card_bucket_info_garment_status_updated.
  ///
  /// In en, this message translates to:
  /// **'Garment/s status updated!'**
  String get client_clothing_info_card_bucket_info_garment_status_updated;

  /// No description provided for @client_clothing_info_card_bucket_info_deselect_use.
  ///
  /// In en, this message translates to:
  /// **'Deselect Use'**
  String get client_clothing_info_card_bucket_info_deselect_use;

  /// No description provided for @client_clothing_info_card_bucket_info_change_name.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get client_clothing_info_card_bucket_info_change_name;

  /// No description provided for @client_clothing_info_card_bucket_info_remove_all.
  ///
  /// In en, this message translates to:
  /// **'Remove All'**
  String get client_clothing_info_card_bucket_info_remove_all;

  /// No description provided for @client_clothing_info_card_cloth_garment_not_found.
  ///
  /// In en, this message translates to:
  /// **'Garment not found!'**
  String get client_clothing_info_card_cloth_garment_not_found;

  /// No description provided for @client_clothing_info_card_cloth_garment_status_updated.
  ///
  /// In en, this message translates to:
  /// **'Condition of the garment/s has changed!'**
  String get client_clothing_info_card_cloth_garment_status_updated;

  /// No description provided for @client_clothing_info_card_cloth_garment_history.
  ///
  /// In en, this message translates to:
  /// **'Garment History'**
  String get client_clothing_info_card_cloth_garment_history;

  /// No description provided for @client_clothing_info_card_cloth_stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get client_clothing_info_card_cloth_stores;

  /// No description provided for @client_clothing_info_card_cloth_actions_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get client_clothing_info_card_cloth_actions_history;

  /// No description provided for @client_clothing_info_card_cloth_blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get client_clothing_info_card_cloth_blocked;

  /// No description provided for @client_clothing_info_card_cloth_in_use.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get client_clothing_info_card_cloth_in_use;

  /// No description provided for @client_clothing_info_card_cloth_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get client_clothing_info_card_cloth_cancel;

  /// No description provided for @client_clothing_info_card_cloth_eco_score.
  ///
  /// In en, this message translates to:
  /// **'Eco-Score'**
  String get client_clothing_info_card_cloth_eco_score;

  /// No description provided for @client_clothing_info_card_cloth_color.
  ///
  /// In en, this message translates to:
  /// **'Color:'**
  String get client_clothing_info_card_cloth_color;

  /// No description provided for @client_clothing_info_card_cloth_size.
  ///
  /// In en, this message translates to:
  /// **'Size:'**
  String get client_clothing_info_card_cloth_size;

  /// No description provided for @client_clothing_info_card_services_garment_not_found.
  ///
  /// In en, this message translates to:
  /// **'Garment not found!'**
  String get client_clothing_info_card_services_garment_not_found;

  /// No description provided for @client_clothing_info_card_services_garments_blocked.
  ///
  /// In en, this message translates to:
  /// **'All the garments are blocked!'**
  String get client_clothing_info_card_services_garments_blocked;

  /// No description provided for @client_clothing_info_card_services_garment_in_use.
  ///
  /// In en, this message translates to:
  /// **'Have at least one item of clothing in use!'**
  String get client_clothing_info_card_services_garment_in_use;

  /// No description provided for @client_clothing_info_card_services_garment_in_service.
  ///
  /// In en, this message translates to:
  /// **'One or more outfits are under maintenance!'**
  String get client_clothing_info_card_services_garment_in_service;

  /// No description provided for @client_clothing_info_card_services_action_registered.
  ///
  /// In en, this message translates to:
  /// **'Action registered!'**
  String get client_clothing_info_card_services_action_registered;

  /// No description provided for @client_clothing_info_card_services_action_unchecked.
  ///
  /// In en, this message translates to:
  /// **'Action cancelled!'**
  String get client_clothing_info_card_services_action_unchecked;

  /// No description provided for @client_clothing_info_card_services_stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get client_clothing_info_card_services_stores;

  /// No description provided for @client_clothing_info_card_services_bucket_created.
  ///
  /// In en, this message translates to:
  /// **'Basket created!'**
  String get client_clothing_info_card_services_bucket_created;

  /// No description provided for @client_clothing_info_card_services_garment_added_bucket.
  ///
  /// In en, this message translates to:
  /// **'Garment/s successfully added to the basket!'**
  String get client_clothing_info_card_services_garment_added_bucket;

  /// No description provided for @client_clothing_info_card_services_removed.
  ///
  /// In en, this message translates to:
  /// **'Successfully removed!'**
  String get client_clothing_info_card_services_removed;

  /// No description provided for @client_clothing_info_card_services_bucket_name.
  ///
  /// In en, this message translates to:
  /// **'Basket name'**
  String get client_clothing_info_card_services_bucket_name;

  /// No description provided for @client_clothing_info_card_services_create_bucket.
  ///
  /// In en, this message translates to:
  /// **'Create basket'**
  String get client_clothing_info_card_services_create_bucket;

  /// No description provided for @client_clothing_info_card_services_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get client_clothing_info_card_services_create;

  /// No description provided for @client_clothing_info_card_services_bucket.
  ///
  /// In en, this message translates to:
  /// **'Bucket'**
  String get client_clothing_info_card_services_bucket;

  /// No description provided for @client_clothing_info_card_services_add_garment.
  ///
  /// In en, this message translates to:
  /// **'Which basket do you want to add this garment to?'**
  String get client_clothing_info_card_services_add_garment;

  /// No description provided for @client_clothing_info_card_services_new_bucket.
  ///
  /// In en, this message translates to:
  /// **'New basket'**
  String get client_clothing_info_card_services_new_bucket;

  /// No description provided for @client_clothing_info_card_services_recycle.
  ///
  /// In en, this message translates to:
  /// **'Send for recycling'**
  String get client_clothing_info_card_services_recycle;

  /// No description provided for @client_clothing_info_card_services_trash.
  ///
  /// In en, this message translates to:
  /// **'Put it in the bin'**
  String get client_clothing_info_card_services_trash;

  /// No description provided for @client_clothing_info_card_services_no_services.
  ///
  /// In en, this message translates to:
  /// **'There are no services available!'**
  String get client_clothing_info_card_services_no_services;

  /// No description provided for @client_profile_domain_feedback_description.
  ///
  /// In en, this message translates to:
  /// **'Please add a description to the feedback!'**
  String get client_profile_domain_feedback_description;

  /// No description provided for @client_profile_domain_feedback_name.
  ///
  /// In en, this message translates to:
  /// **'Please name the feedback!'**
  String get client_profile_domain_feedback_name;

  /// No description provided for @client_profile_domain_profile_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name for the profile'**
  String get client_profile_domain_profile_name;

  /// No description provided for @client_profile_domain_username.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username for the profile'**
  String get client_profile_domain_username;

  /// No description provided for @client_profile_change_profile_params_email_in_use.
  ///
  /// In en, this message translates to:
  /// **'The e-mail is already used by a user'**
  String get client_profile_change_profile_params_email_in_use;

  /// No description provided for @client_profile_change_profile_params_equal_passwords.
  ///
  /// In en, this message translates to:
  /// **'The passwords must be the same'**
  String get client_profile_change_profile_params_equal_passwords;

  /// No description provided for @client_profile_change_profile_params_create_account.
  ///
  /// In en, this message translates to:
  /// **'An account with this profile has been successfully created!'**
  String get client_profile_change_profile_params_create_account;

  /// No description provided for @client_profile_change_profile_params_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get client_profile_change_profile_params_continue;

  /// No description provided for @client_profile_change_profile_params_new_account.
  ///
  /// In en, this message translates to:
  /// **'New Account'**
  String get client_profile_change_profile_params_new_account;

  /// No description provided for @client_profile_change_profile_params_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get client_profile_change_profile_params_email;

  /// No description provided for @client_profile_change_profile_params_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get client_profile_change_profile_params_password;

  /// No description provided for @client_profile_change_profile_params_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get client_profile_change_profile_params_confirm_password;

  /// No description provided for @client_profile_change_profile_params_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get client_profile_change_profile_params_create;

  /// No description provided for @client_profile_change_profile_profile_alter.
  ///
  /// In en, this message translates to:
  /// **'Profile changed!'**
  String get client_profile_change_profile_profile_alter;

  /// No description provided for @client_profile_change_profile_profile_removed.
  ///
  /// In en, this message translates to:
  /// **'PProfile has been removed.'**
  String get client_profile_change_profile_profile_removed;

  /// No description provided for @client_profile_change_profile_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get client_profile_change_profile_continue;

  /// No description provided for @client_profile_change_profile_create_account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to create an account with this profile?'**
  String get client_profile_change_profile_create_account;

  /// No description provided for @client_profile_change_profile_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get client_profile_change_profile_create;

  /// No description provided for @client_profile_change_profile_remove_profile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this profile?'**
  String get client_profile_change_profile_remove_profile;

  /// No description provided for @client_profile_change_profile_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get client_profile_change_profile_remove;

  /// No description provided for @client_profile_change_profile_profiles_eco_score.
  ///
  /// In en, this message translates to:
  /// **'Profiles Eco-Score'**
  String get client_profile_change_profile_profiles_eco_score;

  /// No description provided for @client_profile_change_profile_add_profile.
  ///
  /// In en, this message translates to:
  /// **'Add a profile'**
  String get client_profile_change_profile_add_profile;

  /// No description provided for @client_profile_change_profile_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get client_profile_change_profile_add;

  /// No description provided for @client_profile_change_profile_promote.
  ///
  /// In en, this message translates to:
  /// **'Promote'**
  String get client_profile_change_profile_promote;

  /// No description provided for @client_profile_create_profile_first_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your first and second name separated by a space.'**
  String get client_profile_create_profile_first_last_name;

  /// No description provided for @client_profile_create_profile_username_already_exists.
  ///
  /// In en, this message translates to:
  /// **'The username already exists'**
  String get client_profile_create_profile_username_already_exists;

  /// No description provided for @client_profile_create_profile_profile_created.
  ///
  /// In en, this message translates to:
  /// **'Profile created successfully'**
  String get client_profile_create_profile_profile_created;

  /// No description provided for @client_profile_create_profile_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get client_profile_create_profile_confirm;

  /// No description provided for @client_profile_create_profile_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get client_profile_create_profile_info;

  /// No description provided for @client_profile_create_profile_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get client_profile_create_profile_name;

  /// No description provided for @client_profile_create_profile_birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get client_profile_create_profile_birth_date;

  /// No description provided for @client_profile_create_profile_username.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get client_profile_create_profile_username;

  /// No description provided for @client_profile_create_profile_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get client_profile_create_profile_continue;

  /// No description provided for @client_profile_prizes_prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get client_profile_prizes_prizes;

  /// No description provided for @client_profile_prizes_recommend.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get client_profile_prizes_recommend;

  /// No description provided for @client_profile_prizes_trade_points.
  ///
  /// In en, this message translates to:
  /// **'Exchange Points'**
  String get client_profile_prizes_trade_points;

  /// No description provided for @client_profile_prizes_trade_points_button.
  ///
  /// In en, this message translates to:
  /// **'Click here to exchange points'**
  String get client_profile_prizes_trade_points_button;

  /// No description provided for @client_profile_prizes_dry.
  ///
  /// In en, this message translates to:
  /// **'Dry'**
  String get client_profile_prizes_dry;

  /// No description provided for @client_profile_prizes_wash.
  ///
  /// In en, this message translates to:
  /// **'Wash'**
  String get client_profile_prizes_wash;

  /// No description provided for @client_profile_prizes_iron.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get client_profile_prizes_iron;

  /// No description provided for @client_profile_prizes_repair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get client_profile_prizes_repair;

  /// No description provided for @client_profile_profile_my_medals.
  ///
  /// In en, this message translates to:
  /// **'My Medals'**
  String get client_profile_profile_my_medals;

  /// No description provided for @client_profile_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get client_profile_profile;

  /// No description provided for @client_profile_profile_eco_score.
  ///
  /// In en, this message translates to:
  /// **'Eco-Score'**
  String get client_profile_profile_eco_score;

  /// No description provided for @client_profile_profile_sustainable_points.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Points'**
  String get client_profile_profile_sustainable_points;

  /// No description provided for @client_profile_profile_eco_coins.
  ///
  /// In en, this message translates to:
  /// **'Eco-Coins'**
  String get client_profile_profile_eco_coins;

  /// No description provided for @client_profile_profile_medals.
  ///
  /// In en, this message translates to:
  /// **'Medals'**
  String get client_profile_profile_medals;

  /// No description provided for @client_profile_profile_see_more.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get client_profile_profile_see_more;

  /// No description provided for @client_profile_profile_no_medals.
  ///
  /// In en, this message translates to:
  /// **'There are no medals!'**
  String get client_profile_profile_no_medals;

  /// No description provided for @client_profile_settings_send_feedback_sent.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent!'**
  String get client_profile_settings_send_feedback_sent;

  /// No description provided for @client_profile_settings_send_feedback_send.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get client_profile_settings_send_feedback_send;

  /// No description provided for @client_profile_settings_send_feedback_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get client_profile_settings_send_feedback_title;

  /// No description provided for @client_profile_settings_send_feedback_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get client_profile_settings_send_feedback_description;

  /// No description provided for @client_profile_settings_send_feedback_button.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get client_profile_settings_send_feedback_button;

  /// No description provided for @client_profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get client_profile_settings;

  /// No description provided for @client_profile_settings_end_session.
  ///
  /// In en, this message translates to:
  /// **'End Session!'**
  String get client_profile_settings_end_session;

  /// No description provided for @client_profile_trade_points_done.
  ///
  /// In en, this message translates to:
  /// **'Exchange made!'**
  String get client_profile_trade_points_done;

  /// No description provided for @client_profile_trade_points_prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get client_profile_trade_points_prizes;

  /// No description provided for @client_profile_trade_points_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get client_profile_trade_points_confirm;

  /// No description provided for @client_profile_trade_points_trade_coins.
  ///
  /// In en, this message translates to:
  /// **'Exchange Coins'**
  String get client_profile_trade_points_trade_coins;

  /// No description provided for @client_profile_trade_points_trade_eco_coins_to_sustainable_points.
  ///
  /// In en, this message translates to:
  /// **'Eco-Coins for Sustainable Points'**
  String get client_profile_trade_points_trade_eco_coins_to_sustainable_points;

  /// No description provided for @client_profile_trade_points_trade_sustainable_points_to_eco_coins.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Points for Eco-Coins'**
  String get client_profile_trade_points_trade_sustainable_points_to_eco_coins;

  /// No description provided for @client_register_cloth_domain_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name for the garment'**
  String get client_register_cloth_domain_name;

  /// No description provided for @client_register_cloth_qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get client_register_cloth_qr_code;

  /// No description provided for @common_info_store_comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get common_info_store_comments;

  /// No description provided for @common_info_store_ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get common_info_store_ratings;

  /// No description provided for @common_info_store_no_reviews.
  ///
  /// In en, this message translates to:
  /// **'There are no reviews!'**
  String get common_info_store_no_reviews;

  /// No description provided for @core_domain_employee_worker.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get core_domain_employee_worker;

  /// No description provided for @core_domain_employee_manager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get core_domain_employee_manager;

  /// No description provided for @core_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get core_search;

  /// No description provided for @core_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get core_cancel;

  /// No description provided for @core_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get core_remove;

  /// No description provided for @core_no_wifi.
  ///
  /// In en, this message translates to:
  /// **'No internet!'**
  String get core_no_wifi;

  /// No description provided for @core_read_qr_code.
  ///
  /// In en, this message translates to:
  /// **'Valid QR Code!'**
  String get core_read_qr_code;

  /// No description provided for @core_level_up_message.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'ve reached the next level!'**
  String get core_level_up_message;

  /// No description provided for @core_level_up_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get core_level_up_confirm;

  /// No description provided for @core_level_up_level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get core_level_up_level;

  /// No description provided for @core_geo_api_portugal.
  ///
  /// In en, this message translates to:
  /// **'Portugal'**
  String get core_geo_api_portugal;

  /// No description provided for @core_geo_api_england.
  ///
  /// In en, this message translates to:
  /// **'England'**
  String get core_geo_api_england;

  /// No description provided for @core_geo_api_france.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get core_geo_api_france;

  /// No description provided for @core_widgets_advertisement_card_services_providers.
  ///
  /// In en, this message translates to:
  /// **'Services Provided'**
  String get core_widgets_advertisement_card_services_providers;

  /// No description provided for @core_widgets_advertisement_card_rating.
  ///
  /// In en, this message translates to:
  /// **'Global Rating'**
  String get core_widgets_advertisement_card_rating;

  /// No description provided for @core_eco_score.
  ///
  /// In en, this message translates to:
  /// **'Eco-Score'**
  String get core_eco_score;

  /// No description provided for @core_widgets_chat_content_not_available.
  ///
  /// In en, this message translates to:
  /// **'No longer available!'**
  String get core_widgets_chat_content_not_available;

  /// No description provided for @core_widgets_cloth_card_remove_garment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this garment?'**
  String get core_widgets_cloth_card_remove_garment;

  /// No description provided for @core_widgets_formatted_button_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get core_widgets_formatted_button_loading;

  /// No description provided for @core_widgets_group_header.
  ///
  /// In en, this message translates to:
  /// **'members'**
  String get core_widgets_group_header;

  /// No description provided for @core_widgets_store_header.
  ///
  /// In en, this message translates to:
  /// **'employees'**
  String get core_widgets_store_header;

  /// No description provided for @core_widgets_horizontal_selector_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get core_widgets_horizontal_selector_all;

  /// No description provided for @core_widgets_order_header_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity:'**
  String get core_widgets_order_header_quantity;

  /// No description provided for @core_qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get core_qr_code;

  /// No description provided for @core_invites.
  ///
  /// In en, this message translates to:
  /// **'Invites'**
  String get core_invites;

  /// No description provided for @core_recycle_view.
  ///
  /// In en, this message translates to:
  /// **'There are no records!'**
  String get core_recycle_view;

  /// No description provided for @core_see_more.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get core_see_more;

  /// No description provided for @group_domain_group_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description for the group'**
  String get group_domain_group_description;

  /// No description provided for @group_domain_group_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name for the group'**
  String get group_domain_group_name;

  /// No description provided for @group_domain_username.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username!'**
  String get group_domain_username;

  /// No description provided for @group_domain_type_public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get group_domain_type_public;

  /// No description provided for @group_domain_type_private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get group_domain_type_private;

  /// No description provided for @group_create_group_created.
  ///
  /// In en, this message translates to:
  /// **'Group successfully created!'**
  String get group_create_group_created;

  /// No description provided for @group_create_group_picture_error.
  ///
  /// In en, this message translates to:
  /// **'You need to select an image for the group.'**
  String get group_create_group_picture_error;

  /// No description provided for @group_create_group_create.
  ///
  /// In en, this message translates to:
  /// **'Create a Group'**
  String get group_create_group_create;

  /// No description provided for @group_create_group_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get group_create_group_name;

  /// No description provided for @group_create_group_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get group_create_group_description;

  /// No description provided for @group_create_group_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get group_create_group_register;

  /// No description provided for @group_group_chat_edit_group_updated.
  ///
  /// In en, this message translates to:
  /// **'Group updated!'**
  String get group_group_chat_edit_group_updated;

  /// No description provided for @group_group_chat_edit_group_create_group.
  ///
  /// In en, this message translates to:
  /// **'Create a Group'**
  String get group_group_chat_edit_group_create_group;

  /// No description provided for @group_group_chat_edit_group_new_name.
  ///
  /// In en, this message translates to:
  /// **'New Name'**
  String get group_group_chat_edit_group_new_name;

  /// No description provided for @group_group_chat_edit_group_new_description.
  ///
  /// In en, this message translates to:
  /// **'New Description'**
  String get group_group_chat_edit_group_new_description;

  /// No description provided for @group_group_chat_edit_group_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get group_group_chat_edit_group_confirm;

  /// No description provided for @group_group_chat_report_user.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get group_group_chat_report_user;

  /// No description provided for @group_group_chat_report_msg.
  ///
  /// In en, this message translates to:
  /// **'Report Message'**
  String get group_group_chat_report_msg;

  /// No description provided for @group_group_chat_exchange_done.
  ///
  /// In en, this message translates to:
  /// **'Successful exchange!'**
  String get group_group_chat_exchange_done;

  /// No description provided for @group_group_chat_add_msg.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get group_group_chat_add_msg;

  /// No description provided for @group_group_chat_select_cloth.
  ///
  /// In en, this message translates to:
  /// **'Select an outfit to change'**
  String get group_group_chat_select_cloth;

  /// No description provided for @group_group_chat_ask_trade_cloth.
  ///
  /// In en, this message translates to:
  /// **'Anyone want to change this garment?'**
  String get group_group_chat_ask_trade_cloth;

  /// No description provided for @group_group_chat_enter_msg.
  ///
  /// In en, this message translates to:
  /// **'Enter the message ...'**
  String get group_group_chat_enter_msg;

  /// No description provided for @group_group_chat_members_remove.
  ///
  /// In en, this message translates to:
  /// **'You\'ve been removed from the group!'**
  String get group_group_chat_members_remove;

  /// No description provided for @group_group_chat_members_promoted.
  ///
  /// In en, this message translates to:
  /// **'Member promoted to Administrator!'**
  String get group_group_chat_members_promoted;

  /// No description provided for @group_group_chat_members_demoted.
  ///
  /// In en, this message translates to:
  /// **'Administrator has been demoted!'**
  String get group_group_chat_members_demoted;

  /// No description provided for @group_group_chat_members_invited.
  ///
  /// In en, this message translates to:
  /// **'User has been invited!'**
  String get group_group_chat_members_invited;

  /// No description provided for @group_group_chat_members_invite.
  ///
  /// In en, this message translates to:
  /// **'Invite User'**
  String get group_group_chat_members_invite;

  /// No description provided for @group_group_chat_members_level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get group_group_chat_members_level;

  /// No description provided for @group_group_chat_members_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get group_group_chat_members_username;

  /// No description provided for @group_group_chat_members_members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get group_group_chat_members_members;

  /// No description provided for @group_group_chat_members_members_low.
  ///
  /// In en, this message translates to:
  /// **'members'**
  String get group_group_chat_members_members_low;

  /// No description provided for @group_group_chat_members_demote.
  ///
  /// In en, this message translates to:
  /// **'Demote'**
  String get group_group_chat_members_demote;

  /// No description provided for @group_group_chat_members_promote.
  ///
  /// In en, this message translates to:
  /// **'Promote'**
  String get group_group_chat_members_promote;

  /// No description provided for @group_group_chat_members_remove_group.
  ///
  /// In en, this message translates to:
  /// **'Remove from Group'**
  String get group_group_chat_members_remove_group;

  /// No description provided for @group_group_chat_members_get_out_group.
  ///
  /// In en, this message translates to:
  /// **'Leave the group'**
  String get group_group_chat_members_get_out_group;

  /// No description provided for @group_group_chat_members_admins.
  ///
  /// In en, this message translates to:
  /// **'Administrators'**
  String get group_group_chat_members_admins;

  /// No description provided for @group_group_chat_enter_group.
  ///
  /// In en, this message translates to:
  /// **'Joined the group!'**
  String get group_group_chat_enter_group;

  /// No description provided for @group_group_chat_cancel_invite.
  ///
  /// In en, this message translates to:
  /// **'You cancelled the invitation!'**
  String get group_group_chat_cancel_invite;

  /// No description provided for @group_group_chat_my_groups.
  ///
  /// In en, this message translates to:
  /// **'My Groups'**
  String get group_group_chat_my_groups;

  /// No description provided for @group_group_chat_global_groups.
  ///
  /// In en, this message translates to:
  /// **'Global Groups'**
  String get group_group_chat_global_groups;

  /// No description provided for @group_group_chat_groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get group_group_chat_groups;

  /// No description provided for @group_group_chat_see_more.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get group_group_chat_see_more;

  /// No description provided for @group_group_chat_members.
  ///
  /// In en, this message translates to:
  /// **'members'**
  String get group_group_chat_members;

  /// No description provided for @home_brand_stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get home_brand_stores;

  /// No description provided for @home_brand_no_stores.
  ///
  /// In en, this message translates to:
  /// **'There are no shops!'**
  String get home_brand_no_stores;

  /// No description provided for @home_brand_ads_opportunities.
  ///
  /// In en, this message translates to:
  /// **'Adverts and Opportunities'**
  String get home_brand_ads_opportunities;

  /// No description provided for @home_brand_no_ads.
  ///
  /// In en, this message translates to:
  /// **'There are no adverts!'**
  String get home_brand_no_ads;

  /// No description provided for @home_index_ads_opportunities.
  ///
  /// In en, this message translates to:
  /// **'Adverts and Opportunities'**
  String get home_index_ads_opportunities;

  /// No description provided for @home_index_popular_services.
  ///
  /// In en, this message translates to:
  /// **'Popular Services'**
  String get home_index_popular_services;

  /// No description provided for @home_index_no_service_providers.
  ///
  /// In en, this message translates to:
  /// **'There are no service providers!'**
  String get home_index_no_service_providers;

  /// No description provided for @home_index_dont_show_again.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show up again'**
  String get home_index_dont_show_again;

  /// No description provided for @home_widget_welcome_card_hi.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get home_widget_welcome_card_hi;

  /// No description provided for @service_provider_orders_index_actives.
  ///
  /// In en, this message translates to:
  /// **'Actives'**
  String get service_provider_orders_index_actives;

  /// No description provided for @service_provider_orders_index_finished.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get service_provider_orders_index_finished;

  /// No description provided for @service_provider_orders_index_finish.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get service_provider_orders_index_finish;

  /// No description provided for @service_provider_orders_index_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get service_provider_orders_index_color;

  /// No description provided for @service_provider_orders_index_brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get service_provider_orders_index_brand;

  /// No description provided for @service_provider_orders_index_services_types.
  ///
  /// In en, this message translates to:
  /// **'Type of Services'**
  String get service_provider_orders_index_services_types;

  /// No description provided for @service_provider_orders_index_stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get service_provider_orders_index_stores;

  /// No description provided for @service_provider_orders_index_no_orders.
  ///
  /// In en, this message translates to:
  /// **'There is no orders!'**
  String get service_provider_orders_index_no_orders;

  /// No description provided for @service_provider_orders_index_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get service_provider_orders_index_orders;

  /// No description provided for @service_provider_profile_add_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get service_provider_profile_add_description;

  /// No description provided for @service_provider_profile_add_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get service_provider_profile_add_title;

  /// No description provided for @service_provider_profile_create_prize_created.
  ///
  /// In en, this message translates to:
  /// **'Prize successfully created!'**
  String get service_provider_profile_create_prize_created;

  /// No description provided for @service_provider_profile_create_prize_vouchers_quantity.
  ///
  /// In en, this message translates to:
  /// **'Voucher quantity'**
  String get service_provider_profile_create_prize_vouchers_quantity;

  /// No description provided for @service_provider_profile_create_prize_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get service_provider_profile_create_prize_title;

  /// No description provided for @service_provider_profile_create_prize_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get service_provider_profile_create_prize_description;

  /// No description provided for @service_provider_profile_create_prize_interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get service_provider_profile_create_prize_interval;

  /// No description provided for @service_provider_profile_create_prize_image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get service_provider_profile_create_prize_image;

  /// No description provided for @service_provider_profile_create_prize_cost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get service_provider_profile_create_prize_cost;

  /// No description provided for @service_provider_profile_create_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get service_provider_profile_create_create;

  /// No description provided for @service_provider_profile_profile_remove_ad.
  ///
  /// In en, this message translates to:
  /// **'Remove advertisement'**
  String get service_provider_profile_profile_remove_ad;

  /// No description provided for @service_provider_profile_profile_ad_removed.
  ///
  /// In en, this message translates to:
  /// **'Advertisement removed!'**
  String get service_provider_profile_profile_ad_removed;

  /// No description provided for @service_provider_profile_profile_no_ad.
  ///
  /// In en, this message translates to:
  /// **'There are no advertisement!'**
  String get service_provider_profile_profile_no_ad;

  /// No description provided for @service_provider_profile_profile_no_sp_points.
  ///
  /// In en, this message translates to:
  /// **'No Sustainable Points for any award!'**
  String get service_provider_profile_profile_no_sp_points;

  /// No description provided for @service_provider_profile_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get service_provider_profile_profile;

  /// No description provided for @service_provider_profile_profile_sustainable_points.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Points'**
  String get service_provider_profile_profile_sustainable_points;

  /// No description provided for @service_provider_profile_profile_advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get service_provider_profile_profile_advertisement;

  /// No description provided for @service_provider_profile_profile_promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get service_provider_profile_profile_promotion;

  /// No description provided for @service_provider_profile_profile_voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get service_provider_profile_profile_voucher;

  /// No description provided for @service_provider_profile_profile_prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get service_provider_profile_profile_prizes;

  /// No description provided for @service_provider_profile_profile_active_advertisements.
  ///
  /// In en, this message translates to:
  /// **'Active Advertisements'**
  String get service_provider_profile_profile_active_advertisements;

  /// No description provided for @service_provider_stores_port_number_must_be_number.
  ///
  /// In en, this message translates to:
  /// **'The door number must be a number!'**
  String get service_provider_stores_port_number_must_be_number;

  /// No description provided for @service_provider_stores_street.
  ///
  /// In en, this message translates to:
  /// **'Please enter the shop street!'**
  String get service_provider_stores_street;

  /// No description provided for @service_provider_stores_store_created.
  ///
  /// In en, this message translates to:
  /// **'Shop successfully created!'**
  String get service_provider_stores_store_created;

  /// No description provided for @service_provider_stores_create_store.
  ///
  /// In en, this message translates to:
  /// **'Create a shop'**
  String get service_provider_stores_create_store;

  /// No description provided for @service_provider_stores_create_store_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get service_provider_stores_create_store_name;

  /// No description provided for @service_provider_stores_create_store_street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get service_provider_stores_create_store_street;

  /// No description provided for @service_provider_stores_create_store_zip_code.
  ///
  /// In en, this message translates to:
  /// **'ZIP code'**
  String get service_provider_stores_create_store_zip_code;

  /// No description provided for @service_provider_stores_create_store_port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get service_provider_stores_create_store_port;

  /// No description provided for @service_provider_stores_create_store_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get service_provider_stores_create_store_register;

  /// No description provided for @service_provider_stores_store_index_store_removed.
  ///
  /// In en, this message translates to:
  /// **'Shop removed!'**
  String get service_provider_stores_store_index_store_removed;

  /// No description provided for @service_provider_stores_store_index_workers.
  ///
  /// In en, this message translates to:
  /// **'employees'**
  String get service_provider_stores_store_index_workers;

  /// No description provided for @service_provider_stores_store_index_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get service_provider_stores_store_index_remove;

  /// No description provided for @service_provider_stores_store_index_level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get service_provider_stores_store_index_level;

  /// No description provided for @service_provider_stores_store_index_stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get service_provider_stores_store_index_stores;

  /// No description provided for @service_provider_stores_store_index_no_stores.
  ///
  /// In en, this message translates to:
  /// **'There are no shops!'**
  String get service_provider_stores_store_index_no_stores;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_email_sent.
  ///
  /// In en, this message translates to:
  /// **'Email sent!'**
  String get service_provider_stores_store_index_store_workers_add_worker_email_sent;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get service_provider_stores_store_index_store_workers_add_worker_back;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_worker_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your employee\'s e-mail address'**
  String get service_provider_stores_store_index_store_workers_add_worker_worker_email;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get service_provider_stores_store_index_store_workers_add_worker_name;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get service_provider_stores_store_index_store_workers_add_worker_email;

  /// No description provided for @service_provider_stores_store_index_store_workers_add_worker_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get service_provider_stores_store_index_store_workers_add_worker_continue;

  /// No description provided for @service_provider_stores_store_index_store_workers_worker_removed.
  ///
  /// In en, this message translates to:
  /// **'Employee removed!'**
  String get service_provider_stores_store_index_store_workers_worker_removed;

  /// No description provided for @service_provider_stores_store_index_store_workers_permission_alter.
  ///
  /// In en, this message translates to:
  /// **'Permission changed!'**
  String get service_provider_stores_store_index_store_workers_permission_alter;

  /// No description provided for @service_provider_stores_store_index_store_workers_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get service_provider_stores_store_index_store_workers_remove;

  /// No description provided for @service_provider_stores_store_index_store_workers_workers.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get service_provider_stores_store_index_store_workers_workers;

  /// No description provided for @terms_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get terms_continue;

  /// No description provided for @terms_i_have_read_and_accept.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept the Terms and Conditions'**
  String get terms_i_have_read_and_accept;

  /// No description provided for @terms_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms_terms_and_conditions;

  /// No description provided for @game_quiz_already_done.
  ///
  /// In en, this message translates to:
  /// **'You have already completed today\'s quiz!'**
  String get game_quiz_already_done;

  /// No description provided for @game_quiz_come_back_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow for 5 new questions'**
  String get game_quiz_come_back_tomorrow;

  /// No description provided for @game_quiz_go_back.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get game_quiz_go_back;

  /// No description provided for @game_quiz_completed.
  ///
  /// In en, this message translates to:
  /// **'Quiz completed!'**
  String get game_quiz_completed;

  /// No description provided for @game_quiz_correct_answers.
  ///
  /// In en, this message translates to:
  /// **'correct answers'**
  String get game_quiz_correct_answers;

  /// No description provided for @game_quiz_coins_gained.
  ///
  /// In en, this message translates to:
  /// **'Eco-Coins gained'**
  String get game_quiz_coins_gained;

  /// No description provided for @game_quiz_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get game_quiz_next;

  /// No description provided for @game_quiz_result.
  ///
  /// In en, this message translates to:
  /// **'View Result'**
  String get game_quiz_result;

  /// No description provided for @core_brands_see_brands_report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get core_brands_see_brands_report;

  /// No description provided for @core_brands_see_brands_brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get core_brands_see_brands_brands;

  /// No description provided for @core_brands_create_brand_created.
  ///
  /// In en, this message translates to:
  /// **'Brand successfully created!'**
  String get core_brands_create_brand_created;

  /// No description provided for @core_brands_create_brand_register.
  ///
  /// In en, this message translates to:
  /// **'Register Brand'**
  String get core_brands_create_brand_register;

  /// No description provided for @core_filter_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get core_filter_clear;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @gender_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get gender_other;

  /// No description provided for @gender_not_define.
  ///
  /// In en, this message translates to:
  /// **'I prefer not to say'**
  String get gender_not_define;

  /// No description provided for @language_pt.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get language_pt;

  /// No description provided for @language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_en;
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
