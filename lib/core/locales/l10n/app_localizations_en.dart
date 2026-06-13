import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get auth_login_email => 'E-mail';

  @override
  String get auth_login_password => 'Password';

  @override
  String get auth_login_forgot_password => 'Forgot your password?';

  @override
  String get auth_login_sign_in => 'Login';

  @override
  String get auth_login_got_no_account => 'No Account?';

  @override
  String get auth_login_sign_up => 'Register';

  @override
  String get auth_select_user_type => 'Select User Type';

  @override
  String get auth_select_user_personal_type => 'Personal';

  @override
  String get auth_select_user_enterprise_type => 'Enterprise';

  @override
  String get auth_select_user_finish => 'Continue';

  @override
  String get auth_sign_in_sucess => 'Account successfully created';

  @override
  String get auth_sign_in_enter => 'Enter';

  @override
  String get auth_personal_info => 'Personal Information';

  @override
  String get auth_personal_name => 'Name';

  @override
  String get auth_personal_birth_date => 'Birth Date';

  @override
  String get auth_personal_phone => 'Mobile phone';

  @override
  String get auth_personal_finish => 'Finish';

  @override
  String get auth_personal_insert_first_name_after_the_second => 'Enter your first and second name separated by a space.';

  @override
  String get auth_enterprise_service_provider_info => 'Service Provider Information';

  @override
  String get auth_enterprise_service_provider_laundry => 'Laundry';

  @override
  String get auth_enterprise_service_provider_repair => 'Repair';

  @override
  String get auth_enterprise_address => 'Address';

  @override
  String get auth_enterprise_street => 'Street';

  @override
  String get auth_enterprise_zip_code => 'ZIP code';

  @override
  String get auth_enterprise_port => 'Door Number';

  @override
  String get auth_enterprise_insert_street => 'Please enter the street of your headquarters';

  @override
  String get auth_enterprise_insert_zip_code => 'Enter a zip code';

  @override
  String get auth_enterprise_insert_port => 'Insert a door number';

  @override
  String get auth_enterprise_insert_an_valid_port => 'Insert a valid door number';

  @override
  String get auth_avatar_avatar => 'Avatar';

  @override
  String get auth_avatar_username => 'Display name';

  @override
  String get auth_avatar_finish => 'Continue';

  @override
  String get auth_avatar_user_already_exists => 'The username already exists';

  @override
  String get auth_final_stage_account => 'Account';

  @override
  String get auth_final_stage_email => 'E-mail';

  @override
  String get auth_final_stage_password => 'Password';

  @override
  String get auth_final_stage_confirm_password => 'Confirm password';

  @override
  String get auth_final_stage_finish => 'Continue';

  @override
  String get auth_final_stage_email_already_used => 'The e-mail is already used by a user';

  @override
  String get auth_final_stage_password_must_be_the_same => 'The passwords must be the same';

  @override
  String get auth_code_is_empty => 'Enter the code';

  @override
  String get auth_code_should_have_6_digits => 'The code must have 6 digits';

  @override
  String get auth_email_insert_pls => 'Please enter your email address';

  @override
  String get auth_email_not_valid => 'The email address is invalid';

  @override
  String get auth_name_insert_first_name => 'Please enter your first name';

  @override
  String get auth_name_insert_last_name => 'Please enter your last name';

  @override
  String get auth_name_insert_only_first_and_last => 'Please only enter your first and last name';

  @override
  String get auth_password_btw_8_16 => 'The password must be between 8 and 16 characters long';

  @override
  String get auth_password_must_insert => 'Please enter the password';

  @override
  String get auth_password_at_least_one_number => 'The password must contain at least one number';

  @override
  String get auth_password_should_have_at_lest_one_letter => 'The password must contain at least one capital letter';

  @override
  String get auth_password_at_lest_one_caps => 'The password must contain at least one lowercase letter';

  @override
  String get auth_phone_must_9_numbers => 'The phone number must have 9 numbers';

  @override
  String get auth_zip_code_must_7_numbers => 'The zip code must have 7 numbers';

  @override
  String get auth_username_insert_it => 'Please enter a username';

  @override
  String get client_register_cloth_add_brand => 'Register Brand';

  @override
  String get client_register_cloth_created => 'Garment created!';

  @override
  String get client_register_register_cloth => 'Register garment';

  @override
  String get client_register_imagem => 'Image';

  @override
  String get client_register_size => 'Size';

  @override
  String get client_register_category => 'Category';

  @override
  String get client_register_brand => 'Brand';

  @override
  String get client_register_name => 'Name';

  @override
  String get client_register_color => 'Color';

  @override
  String get client_register_register => 'Register';

  @override
  String get client_register_qr_code => 'QR Code';

  @override
  String get profile_settings_language => 'Language';

  @override
  String get auth_forgot_password_insert_code_error_empty => 'Please enter the code';

  @override
  String get auth_forgot_password_insert_code_send_code => 'A code has been sent to your email address';

  @override
  String get auth_forgot_password_insert_code_insert_code => 'Enter the code sent to your email';

  @override
  String get auth_forgot_password_insert_code_code => 'Code';

  @override
  String get auth_forgot_password_insert_code_continue => 'Continue';

  @override
  String get auth_forgot_password_reset_password_equal_password => 'The passwords must be the same';

  @override
  String get auth_forgot_password_reset_password_changed => 'Password changed successfully!';

  @override
  String get auth_forgot_password_reset_password_new_password => 'Redefine your password';

  @override
  String get auth_forgot_password_reset_password_password => 'Password';

  @override
  String get auth_forgot_password_reset_password_confirm_password => 'Confirm password';

  @override
  String get auth_forgot_password_reset_password_show_password => 'Show password';

  @override
  String get auth_forgot_password_reset_password_continue => 'Continue';

  @override
  String get auth_login_error_email => 'Please enter a valid email address';

  @override
  String get auth_login_email_check_part_1 => 'The user with the email ';

  @override
  String get auth_login_email_check_part_2 => ' does not exist';

  @override
  String get auth_login_request_sended => 'The request has been sent!';

  @override
  String get auth_login_show_password => 'Show password';

  @override
  String get auth_final_stage_finish_show_password => 'Show password';

  @override
  String get client_clothing_contracts_current_service_finish_action => 'Bring the action to a close';

  @override
  String get client_clothing_domain_data_filters_jeans => 'Jeans';

  @override
  String get client_clothing_domain_data_filters_jackets => 'Jackets';

  @override
  String get client_clothing_domain_data_filters_t_shirts => 'T-shirts';

  @override
  String get client_clothing_domain_data_filters_shirts => 'Shirts';

  @override
  String get client_clothing_domain_data_filters_skirts => 'Skirts';

  @override
  String get client_clothing_domain_data_filters_size => 'Size';

  @override
  String get client_clothing_domain_bucket_name_empty => 'Please enter a name for the basket';

  @override
  String get client_clothing_closet_clothing_state_updated => 'Status updated!';

  @override
  String get client_clothing_closet_clothing_removed => 'Successfully removed!';

  @override
  String get client_clothing_closet_clothing_color => 'Color';

  @override
  String get client_clothing_closet_clothing_brand => 'Brand';

  @override
  String get client_clothing_closet_clothing_profiles => 'Profiles';

  @override
  String get client_clothing_closet_clothing_bucket_created => 'Basket created!';

  @override
  String get client_clothing_closet_clothing_no_buckets => 'There are no baskets!';

  @override
  String get client_clothing_closet_clothing_which_bucket => 'Which basket do you want to put this garment in?';

  @override
  String get client_clothing_closet_clothing_garment_added_bucket => 'Garment/s successfully added to basket!';

  @override
  String get client_clothing_closet_clothing_bucket_name => 'Basket name';

  @override
  String get client_clothing_closet_clothing_new_bucket => 'New basket';

  @override
  String get client_clothing_closet_clothing_create_bucket => 'Create basket';

  @override
  String get client_clothing_closet_clothing_create => 'Create';

  @override
  String get client_clothing_closet_clothing_closet => 'Closet';

  @override
  String get client_clothing_closet_clothing_search => 'Search';

  @override
  String get client_clothing_closet_clothing_no_garment => 'There is no garment!';

  @override
  String get client_clothing_info_card_bucket_change_name_updated => 'Basket successfully updated!';

  @override
  String get client_clothing_info_card_bucket_change_name_alter_name => 'Change basket name';

  @override
  String get client_clothing_info_card_bucket_change_name_name => 'Basket name';

  @override
  String get client_clothing_info_card_bucket_change_name_alter => 'Change';

  @override
  String get client_clothing_info_card_bucket_info_error_no_garments_selected => 'There are no selected garments!';

  @override
  String get client_clothing_info_card_bucket_info_garment_removed => 'Garment/s successfully removed!';

  @override
  String get client_clothing_info_card_bucket_info_garment_status_updated => 'Garment/s status updated!';

  @override
  String get client_clothing_info_card_bucket_info_deselect_use => 'Deselect Use';

  @override
  String get client_clothing_info_card_bucket_info_change_name => 'Change Name';

  @override
  String get client_clothing_info_card_bucket_info_remove_all => 'Remove All';

  @override
  String get client_clothing_info_card_cloth_garment_not_found => 'Garment not found!';

  @override
  String get client_clothing_info_card_cloth_garment_status_updated => 'Condition of the garment/s has changed!';

  @override
  String get client_clothing_info_card_cloth_garment_history => 'Garment History';

  @override
  String get client_clothing_info_card_cloth_stores => 'Stores';

  @override
  String get client_clothing_info_card_cloth_actions_history => 'History';

  @override
  String get client_clothing_info_card_cloth_blocked => 'Blocked';

  @override
  String get client_clothing_info_card_cloth_in_use => 'Use';

  @override
  String get client_clothing_info_card_cloth_cancel => 'Cancel';

  @override
  String get client_clothing_info_card_cloth_eco_score => 'Eco-Score';

  @override
  String get client_clothing_info_card_cloth_color => 'Color:';

  @override
  String get client_clothing_info_card_cloth_size => 'Size:';

  @override
  String get client_clothing_info_card_services_garment_not_found => 'Garment not found!';

  @override
  String get client_clothing_info_card_services_garments_blocked => 'All the garments are blocked!';

  @override
  String get client_clothing_info_card_services_garment_in_use => 'Have at least one item of clothing in use!';

  @override
  String get client_clothing_info_card_services_garment_in_service => 'One or more outfits are under maintenance!';

  @override
  String get client_clothing_info_card_services_action_registered => 'Action registered!';

  @override
  String get client_clothing_info_card_services_action_unchecked => 'Action cancelled!';

  @override
  String get client_clothing_info_card_services_stores => 'Stores';

  @override
  String get client_clothing_info_card_services_bucket_created => 'Basket created!';

  @override
  String get client_clothing_info_card_services_garment_added_bucket => 'Garment/s successfully added to the basket!';

  @override
  String get client_clothing_info_card_services_removed => 'Successfully removed!';

  @override
  String get client_clothing_info_card_services_bucket_name => 'Basket name';

  @override
  String get client_clothing_info_card_services_create_bucket => 'Create basket';

  @override
  String get client_clothing_info_card_services_create => 'Create';

  @override
  String get client_clothing_info_card_services_bucket => 'Bucket';

  @override
  String get client_clothing_info_card_services_add_garment => 'Which basket do you want to add this garment to?';

  @override
  String get client_clothing_info_card_services_new_bucket => 'New basket';

  @override
  String get client_clothing_info_card_services_recycle => 'Send for recycling';

  @override
  String get client_clothing_info_card_services_trash => 'Put it in the bin';

  @override
  String get client_clothing_info_card_services_no_services => 'There are no services available!';

  @override
  String get client_profile_domain_feedback_description => 'Please add a description to the feedback!';

  @override
  String get client_profile_domain_feedback_name => 'Please name the feedback!';

  @override
  String get client_profile_domain_profile_name => 'Please enter a name for the profile';

  @override
  String get client_profile_domain_username => 'Please enter a username for the profile';

  @override
  String get client_profile_change_profile_params_email_in_use => 'The e-mail is already used by a user';

  @override
  String get client_profile_change_profile_params_equal_passwords => 'The passwords must be the same';

  @override
  String get client_profile_change_profile_params_create_account => 'An account with this profile has been successfully created!';

  @override
  String get client_profile_change_profile_params_continue => 'Continue';

  @override
  String get client_profile_change_profile_params_new_account => 'New Account';

  @override
  String get client_profile_change_profile_params_email => 'E-mail';

  @override
  String get client_profile_change_profile_params_password => 'Password';

  @override
  String get client_profile_change_profile_params_confirm_password => 'Confirm password';

  @override
  String get client_profile_change_profile_params_create => 'Create';

  @override
  String get client_profile_change_profile_profile_alter => 'Profile changed!';

  @override
  String get client_profile_change_profile_profile_removed => 'PProfile has been removed.';

  @override
  String get client_profile_change_profile_continue => 'Continue';

  @override
  String get client_profile_change_profile_create_account => 'Are you sure you want to create an account with this profile?';

  @override
  String get client_profile_change_profile_create => 'Create';

  @override
  String get client_profile_change_profile_remove_profile => 'Are you sure you want to remove this profile?';

  @override
  String get client_profile_change_profile_remove => 'Remove';

  @override
  String get client_profile_change_profile_profiles_eco_score => 'Profiles Eco-Score';

  @override
  String get client_profile_change_profile_add_profile => 'Add a profile';

  @override
  String get client_profile_change_profile_add => 'Add';

  @override
  String get client_profile_change_profile_promote => 'Promote';

  @override
  String get client_profile_create_profile_first_last_name => 'Enter your first and second name separated by a space.';

  @override
  String get client_profile_create_profile_username_already_exists => 'The username already exists';

  @override
  String get client_profile_create_profile_profile_created => 'Profile created successfully';

  @override
  String get client_profile_create_profile_confirm => 'Confirm';

  @override
  String get client_profile_create_profile_info => 'Personal Information';

  @override
  String get client_profile_create_profile_name => 'Name';

  @override
  String get client_profile_create_profile_birth_date => 'Birth Date';

  @override
  String get client_profile_create_profile_username => 'Display name';

  @override
  String get client_profile_create_profile_continue => 'Continue';

  @override
  String get client_profile_prizes_prizes => 'Prizes';

  @override
  String get client_profile_prizes_recommend => 'Recommended for you';

  @override
  String get client_profile_prizes_trade_points => 'Exchange Points';

  @override
  String get client_profile_prizes_trade_points_button => 'Click here to exchange points';

  @override
  String get client_profile_prizes_dry => 'Dry';

  @override
  String get client_profile_prizes_wash => 'Wash';

  @override
  String get client_profile_prizes_iron => 'Iron';

  @override
  String get client_profile_prizes_repair => 'Repair';

  @override
  String get client_profile_profile_my_medals => 'My Medals';

  @override
  String get client_profile_profile => 'Profile';

  @override
  String get client_profile_profile_eco_score => 'Eco-Score';

  @override
  String get client_profile_profile_sustainable_points => 'Sustainable Points';

  @override
  String get client_profile_profile_eco_coins => 'Eco-Coins';

  @override
  String get client_profile_profile_medals => 'Medals';

  @override
  String get client_profile_profile_see_more => 'See more';

  @override
  String get client_profile_profile_no_medals => 'There are no medals!';

  @override
  String get client_profile_settings_send_feedback_sent => 'Feedback sent!';

  @override
  String get client_profile_settings_send_feedback_send => 'Send Feedback';

  @override
  String get client_profile_settings_send_feedback_title => 'Title';

  @override
  String get client_profile_settings_send_feedback_description => 'Description';

  @override
  String get client_profile_settings_send_feedback_button => 'Send';

  @override
  String get client_profile_settings => 'Settings';

  @override
  String get client_profile_settings_end_session => 'End Session!';

  @override
  String get client_profile_trade_points_done => 'Exchange made!';

  @override
  String get client_profile_trade_points_prizes => 'Prizes';

  @override
  String get client_profile_trade_points_confirm => 'Confirm';

  @override
  String get client_profile_trade_points_trade_coins => 'Exchange Coins';

  @override
  String get client_profile_trade_points_trade_eco_coins_to_sustainable_points => 'Eco-Coins for Sustainable Points';

  @override
  String get client_profile_trade_points_trade_sustainable_points_to_eco_coins => 'Sustainable Points for Eco-Coins';

  @override
  String get client_register_cloth_domain_name => 'Please enter a name for the garment';

  @override
  String get client_register_cloth_qr_code => 'QR Code';

  @override
  String get common_info_store_comments => 'Comments';

  @override
  String get common_info_store_ratings => 'Ratings';

  @override
  String get common_info_store_no_reviews => 'There are no reviews!';

  @override
  String get core_domain_employee_worker => 'Employee';

  @override
  String get core_domain_employee_manager => 'Manager';

  @override
  String get core_search => 'Search';

  @override
  String get core_cancel => 'Cancel';

  @override
  String get core_remove => 'Remove';

  @override
  String get core_no_wifi => 'No internet!';

  @override
  String get core_read_qr_code => 'Valid QR Code!';

  @override
  String get core_level_up_message => 'Congratulations! You\'ve reached the next level!';

  @override
  String get core_level_up_confirm => 'Confirm';

  @override
  String get core_level_up_level => 'Level';

  @override
  String get core_geo_api_portugal => 'Portugal';

  @override
  String get core_geo_api_england => 'England';

  @override
  String get core_geo_api_france => 'France';

  @override
  String get core_widgets_advertisement_card_services_providers => 'Services Provided';

  @override
  String get core_widgets_advertisement_card_rating => 'Global Rating';

  @override
  String get core_eco_score => 'Eco-Score';

  @override
  String get core_widgets_chat_content_not_available => 'No longer available!';

  @override
  String get core_widgets_cloth_card_remove_garment => 'Are you sure you want to remove this garment?';

  @override
  String get core_widgets_formatted_button_loading => 'Loading';

  @override
  String get core_widgets_group_header => 'members';

  @override
  String get core_widgets_store_header => 'employees';

  @override
  String get core_widgets_horizontal_selector_all => 'All';

  @override
  String get core_widgets_order_header_quantity => 'Quantity:';

  @override
  String get core_qr_code => 'QR Code';

  @override
  String get core_invites => 'Invites';

  @override
  String get core_recycle_view => 'There are no records!';

  @override
  String get core_see_more => 'See more';

  @override
  String get group_domain_group_description => 'Please enter a description for the group';

  @override
  String get group_domain_group_name => 'Please enter a name for the group';

  @override
  String get group_domain_username => 'Please enter a username!';

  @override
  String get group_domain_type_public => 'Public';

  @override
  String get group_domain_type_private => 'Private';

  @override
  String get group_create_group_created => 'Group successfully created!';

  @override
  String get group_create_group_picture_error => 'You need to select an image for the group.';

  @override
  String get group_create_group_create => 'Create a Group';

  @override
  String get group_create_group_name => 'Name';

  @override
  String get group_create_group_description => 'Description';

  @override
  String get group_create_group_register => 'Register';

  @override
  String get group_group_chat_edit_group_updated => 'Group updated!';

  @override
  String get group_group_chat_edit_group_create_group => 'Create a Group';

  @override
  String get group_group_chat_edit_group_new_name => 'New Name';

  @override
  String get group_group_chat_edit_group_new_description => 'New Description';

  @override
  String get group_group_chat_edit_group_confirm => 'Confirm';

  @override
  String get group_group_chat_report_user => 'Report User';

  @override
  String get group_group_chat_report_msg => 'Report Message';

  @override
  String get group_group_chat_exchange_done => 'Successful exchange!';

  @override
  String get group_group_chat_add_msg => 'Type a message';

  @override
  String get group_group_chat_select_cloth => 'Select an outfit to change';

  @override
  String get group_group_chat_ask_trade_cloth => 'Anyone want to change this garment?';

  @override
  String get group_group_chat_enter_msg => 'Enter the message ...';

  @override
  String get group_group_chat_members_remove => 'You\'ve been removed from the group!';

  @override
  String get group_group_chat_members_promoted => 'Member promoted to Administrator!';

  @override
  String get group_group_chat_members_demoted => 'Administrator has been demoted!';

  @override
  String get group_group_chat_members_invited => 'User has been invited!';

  @override
  String get group_group_chat_members_invite => 'Invite User';

  @override
  String get group_group_chat_members_level => 'Level';

  @override
  String get group_group_chat_members_username => 'Username';

  @override
  String get group_group_chat_members_members => 'Members';

  @override
  String get group_group_chat_members_members_low => 'members';

  @override
  String get group_group_chat_members_demote => 'Demote';

  @override
  String get group_group_chat_members_promote => 'Promote';

  @override
  String get group_group_chat_members_remove_group => 'Remove from Group';

  @override
  String get group_group_chat_members_get_out_group => 'Leave the group';

  @override
  String get group_group_chat_members_admins => 'Administrators';

  @override
  String get group_group_chat_enter_group => 'Joined the group!';

  @override
  String get group_group_chat_cancel_invite => 'You cancelled the invitation!';

  @override
  String get group_group_chat_my_groups => 'My Groups';

  @override
  String get group_group_chat_global_groups => 'Global Groups';

  @override
  String get group_group_chat_groups => 'Groups';

  @override
  String get group_group_chat_see_more => 'See more';

  @override
  String get group_group_chat_members => 'members';

  @override
  String get home_brand_stores => 'Stores';

  @override
  String get home_brand_no_stores => 'There are no shops!';

  @override
  String get home_brand_ads_opportunities => 'Adverts and Opportunities';

  @override
  String get home_brand_no_ads => 'There are no adverts!';

  @override
  String get home_index_ads_opportunities => 'Adverts and Opportunities';

  @override
  String get home_index_popular_services => 'Popular Services';

  @override
  String get home_index_no_service_providers => 'There are no service providers!';

  @override
  String get home_index_dont_show_again => 'Don\'t show up again';

  @override
  String get home_widget_welcome_card_hi => 'Welcome!';

  @override
  String get service_provider_orders_index_actives => 'Actives';

  @override
  String get service_provider_orders_index_finished => 'Completed';

  @override
  String get service_provider_orders_index_finish => 'Completed';

  @override
  String get service_provider_orders_index_color => 'Color';

  @override
  String get service_provider_orders_index_brand => 'Brand';

  @override
  String get service_provider_orders_index_services_types => 'Type of Services';

  @override
  String get service_provider_orders_index_stores => 'Stores';

  @override
  String get service_provider_orders_index_no_orders => 'There is no orders!';

  @override
  String get service_provider_orders_index_orders => 'Orders';

  @override
  String get service_provider_profile_add_description => 'Please enter a description';

  @override
  String get service_provider_profile_add_title => 'Please enter a title';

  @override
  String get service_provider_profile_create_prize_created => 'Prize successfully created!';

  @override
  String get service_provider_profile_create_prize_vouchers_quantity => 'Voucher quantity';

  @override
  String get service_provider_profile_create_prize_title => 'Title';

  @override
  String get service_provider_profile_create_prize_description => 'Description';

  @override
  String get service_provider_profile_create_prize_interval => 'Interval';

  @override
  String get service_provider_profile_create_prize_image => 'Image';

  @override
  String get service_provider_profile_create_prize_cost => 'Cost';

  @override
  String get service_provider_profile_create_create => 'Create';

  @override
  String get service_provider_profile_profile_remove_ad => 'Remove advertisement';

  @override
  String get service_provider_profile_profile_ad_removed => 'Advertisement removed!';

  @override
  String get service_provider_profile_profile_no_ad => 'There are no advertisement!';

  @override
  String get service_provider_profile_profile_no_sp_points => 'No Sustainable Points for any award!';

  @override
  String get service_provider_profile_profile => 'Profile';

  @override
  String get service_provider_profile_profile_sustainable_points => 'Sustainable Points';

  @override
  String get service_provider_profile_profile_advertisement => 'Advertisement';

  @override
  String get service_provider_profile_profile_promotion => 'Promotion';

  @override
  String get service_provider_profile_profile_voucher => 'Voucher';

  @override
  String get service_provider_profile_profile_prizes => 'Prizes';

  @override
  String get service_provider_profile_profile_active_advertisements => 'Active Advertisements';

  @override
  String get service_provider_stores_port_number_must_be_number => 'The door number must be a number!';

  @override
  String get service_provider_stores_street => 'Please enter the shop street!';

  @override
  String get service_provider_stores_store_created => 'Shop successfully created!';

  @override
  String get service_provider_stores_create_store => 'Create a shop';

  @override
  String get service_provider_stores_create_store_name => 'Name';

  @override
  String get service_provider_stores_create_store_street => 'Street';

  @override
  String get service_provider_stores_create_store_zip_code => 'ZIP code';

  @override
  String get service_provider_stores_create_store_port => 'Port';

  @override
  String get service_provider_stores_create_store_register => 'Register';

  @override
  String get service_provider_stores_store_index_store_removed => 'Shop removed!';

  @override
  String get service_provider_stores_store_index_workers => 'employees';

  @override
  String get service_provider_stores_store_index_remove => 'Remove';

  @override
  String get service_provider_stores_store_index_level => 'Level';

  @override
  String get service_provider_stores_store_index_stores => 'Stores';

  @override
  String get service_provider_stores_store_index_no_stores => 'There are no shops!';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_email_sent => 'Email sent!';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_back => 'Back';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_worker_email => 'Enter your employee\'s e-mail address';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_name => 'Name';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_email => 'Email';

  @override
  String get service_provider_stores_store_index_store_workers_add_worker_continue => 'Continue';

  @override
  String get service_provider_stores_store_index_store_workers_worker_removed => 'Employee removed!';

  @override
  String get service_provider_stores_store_index_store_workers_permission_alter => 'Permission changed!';

  @override
  String get service_provider_stores_store_index_store_workers_remove => 'Remove';

  @override
  String get service_provider_stores_store_index_store_workers_workers => 'Employees';

  @override
  String get terms_continue => 'Continue';

  @override
  String get terms_i_have_read_and_accept => 'I have read and accept the Terms and Conditions';

  @override
  String get terms_terms_and_conditions => 'Terms and Conditions';

  @override
  String get game_quiz_already_done => 'You have already completed today\'s quiz!';

  @override
  String get game_quiz_come_back_tomorrow => 'Come back tomorrow for 5 new questions';

  @override
  String get game_quiz_go_back => 'Go Back';

  @override
  String get game_quiz_completed => 'Quiz completed!';

  @override
  String get game_quiz_correct_answers => 'correct answers';

  @override
  String get game_quiz_coins_gained => 'Eco-Coins gained';

  @override
  String get game_quiz_next => 'Next';

  @override
  String get game_quiz_result => 'View Result';

  @override
  String get core_brands_see_brands_report => 'Report';

  @override
  String get core_brands_see_brands_brands => 'Brands';

  @override
  String get core_brands_create_brand_created => 'Brand successfully created!';

  @override
  String get core_brands_create_brand_register => 'Register Brand';

  @override
  String get core_filter_clear => 'Clear';

  @override
  String get gender_male => 'Male';

  @override
  String get gender_female => 'Female';

  @override
  String get gender_other => 'Other';

  @override
  String get gender_not_define => 'I prefer not to say';

  @override
  String get language_pt => 'Portuguese';

  @override
  String get language_en => 'English';
}
