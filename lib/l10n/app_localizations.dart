import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tawasul'**
  String get appName;

  /// No description provided for @splashNmae.
  ///
  /// In en, this message translates to:
  /// **'Government Complaints App'**
  String get splashNmae;

  /// Shows how many items are selected
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selected_count(int count);

  /// No description provided for @arrow_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get arrow_back;

  /// No description provided for @confirm_entry.
  ///
  /// In en, this message translates to:
  /// **'Confirm entry'**
  String get confirm_entry;

  /// No description provided for @confirm_of_dispatch.
  ///
  /// In en, this message translates to:
  /// **'Confirm sending'**
  String get confirm_of_dispatch;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @closing.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closing;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @app_description.
  ///
  /// In en, this message translates to:
  /// **'An app that helps citizens create, organize,\n and track complaints\nefficiently and easily'**
  String get app_description;

  /// No description provided for @new_account.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get new_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @brand_part1.
  ///
  /// In en, this message translates to:
  /// **'Ta'**
  String get brand_part1;

  /// No description provided for @brand_part2.
  ///
  /// In en, this message translates to:
  /// **'wasul'**
  String get brand_part2;

  /// No description provided for @email_field.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_field;

  /// No description provided for @password_field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_field;

  /// No description provided for @name_field.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name_field;

  /// No description provided for @national_number_field.
  ///
  /// In en, this message translates to:
  /// **'National number'**
  String get national_number_field;

  /// No description provided for @new_password_field.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get new_password_field;

  /// No description provided for @email_field_hint.
  ///
  /// In en, this message translates to:
  /// **'enter your email...'**
  String get email_field_hint;

  /// No description provided for @password_field_hint.
  ///
  /// In en, this message translates to:
  /// **'enter your password...'**
  String get password_field_hint;

  /// No description provided for @name_field_hint.
  ///
  /// In en, this message translates to:
  /// **'enter your name in Arabic...'**
  String get name_field_hint;

  /// No description provided for @national_number_field_hint.
  ///
  /// In en, this message translates to:
  /// **'enter your national number...'**
  String get national_number_field_hint;

  /// No description provided for @new_password_field_hint.
  ///
  /// In en, this message translates to:
  /// **'enter the password again...'**
  String get new_password_field_hint;

  /// No description provided for @login_description.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Log in and help build a new Syria.'**
  String get login_description;

  /// No description provided for @did_you_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get did_you_forget_password;

  /// No description provided for @didnt_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? Create one'**
  String get didnt_have_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @signup_description.
  ///
  /// In en, this message translates to:
  /// **'Join us and start your journey with a smoother experience with government institutions'**
  String get signup_description;

  /// No description provided for @did_you_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Go to'**
  String get did_you_have_account;

  /// No description provided for @signup_verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify account'**
  String get signup_verify_email;

  /// No description provided for @signup_verify_email_description.
  ///
  /// In en, this message translates to:
  /// **'Dear user, please verify your email by entering the 6-digit code. Note that you will lose your code if you leave this page.'**
  String get signup_verify_email_description;

  /// No description provided for @signup_verify_email_note.
  ///
  /// In en, this message translates to:
  /// **'This is an extra security step'**
  String get signup_verify_email_note;

  /// No description provided for @input_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get input_otp_code;

  /// No description provided for @didnt_get_code.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive a code?'**
  String get didnt_get_code;

  /// No description provided for @resent_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resent_otp_code;

  /// No description provided for @forget_password_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to receive a verification code'**
  String get forget_password_description;

  /// No description provided for @forget_password_verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify entered email'**
  String get forget_password_verify_email;

  /// No description provided for @forget_password_verify_email_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code sent to your email'**
  String get forget_password_verify_email_description;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get new_password;

  /// No description provided for @new_password_description.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from the previous one'**
  String get new_password_description;

  /// No description provided for @search_in_complaints.
  ///
  /// In en, this message translates to:
  /// **'search in complaints'**
  String get search_in_complaints;

  /// No description provided for @add_new_complaint.
  ///
  /// In en, this message translates to:
  /// **'Add a new complaint'**
  String get add_new_complaint;

  /// No description provided for @complaint_number.
  ///
  /// In en, this message translates to:
  /// **'Complaint number'**
  String get complaint_number;

  /// No description provided for @complaint_description.
  ///
  /// In en, this message translates to:
  /// **'Complaint description'**
  String get complaint_description;

  /// No description provided for @top_bar_complaints_details.
  ///
  /// In en, this message translates to:
  /// **'Complaint details'**
  String get top_bar_complaints_details;

  /// No description provided for @complaint_attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get complaint_attachments;

  /// No description provided for @complaint_info.
  ///
  /// In en, this message translates to:
  /// **'Complaint info'**
  String get complaint_info;

  /// No description provided for @complaint_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get complaint_type;

  /// No description provided for @government_agency.
  ///
  /// In en, this message translates to:
  /// **'Government agency'**
  String get government_agency;

  /// No description provided for @date_of_ceartion.
  ///
  /// In en, this message translates to:
  /// **'Creation date'**
  String get date_of_ceartion;

  /// No description provided for @complaint_location.
  ///
  /// In en, this message translates to:
  /// **'Complaint address'**
  String get complaint_location;

  /// No description provided for @complaints_history_home.
  ///
  /// In en, this message translates to:
  /// **'Complaint history'**
  String get complaints_history_home;

  /// No description provided for @complaints_history.
  ///
  /// In en, this message translates to:
  /// **'Complaint stages'**
  String get complaints_history;

  /// No description provided for @add_more_attachments.
  ///
  /// In en, this message translates to:
  /// **'Attach additional information'**
  String get add_more_attachments;

  /// No description provided for @delete_complaint.
  ///
  /// In en, this message translates to:
  /// **'Delete complaint'**
  String get delete_complaint;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @additional_description.
  ///
  /// In en, this message translates to:
  /// **'Additional description'**
  String get additional_description;

  /// No description provided for @additional_description_hint.
  ///
  /// In en, this message translates to:
  /// **'enter an additional description of the issue...'**
  String get additional_description_hint;

  /// No description provided for @additional_attachment.
  ///
  /// In en, this message translates to:
  /// **'Additional attachment'**
  String get additional_attachment;

  /// No description provided for @additional_attachment_hint.
  ///
  /// In en, this message translates to:
  /// **'add an attachment for the complaint...'**
  String get additional_attachment_hint;

  /// No description provided for @more_info_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'Additional information'**
  String get more_info_bottom_sheet;

  /// No description provided for @notification_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_bottom_sheet;

  /// No description provided for @not_found_notification.
  ///
  /// In en, this message translates to:
  /// **'No notifications at the moment'**
  String get not_found_notification;

  /// No description provided for @top_bar_submit_complaint.
  ///
  /// In en, this message translates to:
  /// **'Submit a complaint'**
  String get top_bar_submit_complaint;

  /// No description provided for @complaint_name.
  ///
  /// In en, this message translates to:
  /// **'Complaint title'**
  String get complaint_name;

  /// No description provided for @complaint_name_hint.
  ///
  /// In en, this message translates to:
  /// **'enter a title for your complaint...'**
  String get complaint_name_hint;

  /// No description provided for @complaint_type_hint.
  ///
  /// In en, this message translates to:
  /// **'select complaint type...'**
  String get complaint_type_hint;

  /// No description provided for @government_agency_hint.
  ///
  /// In en, this message translates to:
  /// **'select government agency...'**
  String get government_agency_hint;

  /// No description provided for @problem_description.
  ///
  /// In en, this message translates to:
  /// **'Problem description'**
  String get problem_description;

  /// No description provided for @problem_description_hint.
  ///
  /// In en, this message translates to:
  /// **'describe the issue you are facing...'**
  String get problem_description_hint;

  /// No description provided for @compliant_location_hint.
  ///
  /// In en, this message translates to:
  /// **'enter the complaint address...'**
  String get compliant_location_hint;

  /// No description provided for @complaint_attachments_hint.
  ///
  /// In en, this message translates to:
  /// **'Add complaint attachments (optional)...'**
  String get complaint_attachments_hint;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get dark_mode;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get light_mode;

  /// No description provided for @did_you_want_logout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get did_you_want_logout;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @not_found_complaints.
  ///
  /// In en, this message translates to:
  /// **'No complaints at the moment'**
  String get not_found_complaints;

  /// No description provided for @show_more.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get show_more;

  /// No description provided for @not_found_searching.
  ///
  /// In en, this message translates to:
  /// **'No complaint found with this number'**
  String get not_found_searching;

  /// No description provided for @unexpected_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpected_error;

  /// No description provided for @otp_has_sent.
  ///
  /// In en, this message translates to:
  /// **'A verification code has been sent to your email'**
  String get otp_has_sent;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get please_enter_email;

  /// No description provided for @password_updated_ok.
  ///
  /// In en, this message translates to:
  /// **'Your new password has been set successfully. You can log in now.'**
  String get password_updated_ok;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_enter_password;

  /// No description provided for @password_at_least.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_at_least;

  /// No description provided for @passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_not_match;

  /// No description provided for @resent_otp_done.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent to your email'**
  String get resent_otp_done;

  /// No description provided for @verify_success.
  ///
  /// In en, this message translates to:
  /// **'Code verified successfully'**
  String get verify_success;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully. Welcome back!'**
  String get login_success;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Operation completed successfully'**
  String get success;

  /// No description provided for @please_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get please_enter_name;

  /// No description provided for @please_enter_national_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your national number'**
  String get please_enter_national_number;

  /// No description provided for @national_number_atleast.
  ///
  /// In en, this message translates to:
  /// **'National number must be 11 digits'**
  String get national_number_atleast;

  /// No description provided for @delete_complaint_done.
  ///
  /// In en, this message translates to:
  /// **'Complaint deleted successfully'**
  String get delete_complaint_done;

  /// No description provided for @not_found_history.
  ///
  /// In en, this message translates to:
  /// **'No history yet for this complaint.'**
  String get not_found_history;

  /// No description provided for @info_sent_success.
  ///
  /// In en, this message translates to:
  /// **'Additional information sent successfully'**
  String get info_sent_success;

  /// No description provided for @logout_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while logging out'**
  String get logout_error;

  /// No description provided for @complaint_sent.
  ///
  /// In en, this message translates to:
  /// **'Complaint submitted successfully'**
  String get complaint_sent;

  /// No description provided for @download_agency.
  ///
  /// In en, this message translates to:
  /// **'Loading agencies...'**
  String get download_agency;

  /// No description provided for @download_types.
  ///
  /// In en, this message translates to:
  /// **'Loading complaint types...'**
  String get download_types;

  /// No description provided for @otp_invalid_6_digits.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get otp_invalid_6_digits;

  /// No description provided for @photos_selected.
  ///
  /// In en, this message translates to:
  /// **'Selected photos'**
  String get photos_selected;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
