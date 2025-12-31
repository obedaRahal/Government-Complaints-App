// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Tawasul';

  @override
  String get splashNmae => 'Government Complaints App';

  @override
  String selected_count(int count) {
    return '$count selected';
  }

  @override
  String get arrow_back => 'Back';

  @override
  String get confirm_entry => 'Confirm entry';

  @override
  String get confirm_of_dispatch => 'Confirm sending';

  @override
  String get common_ok => 'Next';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get closing => 'Close';

  @override
  String get welcome => 'Welcome!';

  @override
  String get app_description =>
      'An app that helps citizens create, organize,\n and track complaints\nefficiently and easily';

  @override
  String get new_account => 'Sign up';

  @override
  String get login => 'Log in';

  @override
  String get brand_part1 => 'Ta';

  @override
  String get brand_part2 => 'wasul';

  @override
  String get email_field => 'Email';

  @override
  String get password_field => 'Password';

  @override
  String get name_field => 'Name';

  @override
  String get national_number_field => 'National number';

  @override
  String get new_password_field => 'Confirm password';

  @override
  String get email_field_hint => 'enter your email...';

  @override
  String get password_field_hint => 'enter your password...';

  @override
  String get name_field_hint => 'enter your name in Arabic...';

  @override
  String get national_number_field_hint => 'enter your national number...';

  @override
  String get new_password_field_hint => 'enter the password again...';

  @override
  String get login_description =>
      'Welcome back. Log in and help build a new Syria.';

  @override
  String get did_you_forget_password => 'Forgot your password?';

  @override
  String get didnt_have_account => 'Don’t have an account? Create one';

  @override
  String get signup => 'Sign up';

  @override
  String get signup_description =>
      'Join us and start your journey with a smoother experience with government institutions';

  @override
  String get did_you_have_account => 'Already have an account? Go to';

  @override
  String get signup_verify_email => 'Verify account';

  @override
  String get signup_verify_email_description =>
      'Dear user, please verify your email by entering the 6-digit code. Note that you will lose your code if you leave this page.';

  @override
  String get signup_verify_email_note => 'This is an extra security step';

  @override
  String get input_otp_code => 'Enter the code';

  @override
  String get didnt_get_code => 'Didn’t receive a code?';

  @override
  String get resent_otp_code => 'Resend code';

  @override
  String get forget_password_description =>
      'Please enter your email address to receive a verification code';

  @override
  String get forget_password_verify_email => 'Verify entered email';

  @override
  String get forget_password_verify_email_description =>
      'Please enter the 6-digit code sent to your email';

  @override
  String get new_password => 'Create a new password';

  @override
  String get new_password_description =>
      'Your new password must be different from the previous one';

  @override
  String get search_in_complaints => 'search in complaints';

  @override
  String get add_new_complaint => 'Add a new complaint';

  @override
  String get complaint_number => 'Complaint number';

  @override
  String get complaint_description => 'Complaint description';

  @override
  String get top_bar_complaints_details => 'Complaint details';

  @override
  String get complaint_attachments => 'Attachments';

  @override
  String get complaint_info => 'Complaint info';

  @override
  String get complaint_type => 'Type';

  @override
  String get government_agency => 'Government agency';

  @override
  String get date_of_ceartion => 'Creation date';

  @override
  String get complaint_location => 'Complaint address';

  @override
  String get complaints_history_home => 'Complaint history';

  @override
  String get complaints_history => 'Complaint stages';

  @override
  String get add_more_attachments => 'Attach additional information';

  @override
  String get delete_complaint => 'Delete complaint';

  @override
  String get notes => 'Notes';

  @override
  String get additional_description => 'Additional description';

  @override
  String get additional_description_hint =>
      'enter an additional description of the issue...';

  @override
  String get additional_attachment => 'Additional attachment';

  @override
  String get additional_attachment_hint =>
      'add an attachment for the complaint...';

  @override
  String get more_info_bottom_sheet => 'Additional information';

  @override
  String get notification_bottom_sheet => 'Notifications';

  @override
  String get not_found_notification => 'No notifications at the moment';

  @override
  String get top_bar_submit_complaint => 'Submit a complaint';

  @override
  String get complaint_name => 'Complaint title';

  @override
  String get complaint_name_hint => 'enter a title for your complaint...';

  @override
  String get complaint_type_hint => 'select complaint type...';

  @override
  String get government_agency_hint => 'select government agency...';

  @override
  String get problem_description => 'Problem description';

  @override
  String get problem_description_hint => 'describe the issue you are facing...';

  @override
  String get compliant_location_hint => 'enter the complaint address...';

  @override
  String get complaint_attachments_hint =>
      'Add complaint attachments (optional)...';

  @override
  String get settings => 'Settings';

  @override
  String get dark_mode => 'Dark mode';

  @override
  String get light_mode => 'Light mode';

  @override
  String get did_you_want_logout => 'Do you want to log out?';

  @override
  String get logout => 'Log out';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get not_found_complaints => 'No complaints at the moment';

  @override
  String get show_more => 'Show more';

  @override
  String get not_found_searching => 'No complaint found with this number';

  @override
  String get unexpected_error => 'An unexpected error occurred';

  @override
  String get otp_has_sent => 'A verification code has been sent to your email';

  @override
  String get please_enter_email => 'Please enter your email';

  @override
  String get password_updated_ok =>
      'Your new password has been set successfully. You can log in now.';

  @override
  String get please_enter_password => 'Please enter your password';

  @override
  String get password_at_least => 'Password must be at least 6 characters';

  @override
  String get passwords_not_match => 'Passwords do not match';

  @override
  String get resent_otp_done => 'A new code has been sent to your email';

  @override
  String get verify_success => 'Code verified successfully';

  @override
  String get login_success => 'Logged in successfully. Welcome back!';

  @override
  String get success => 'Operation completed successfully';

  @override
  String get please_enter_name => 'Please enter your name';

  @override
  String get please_enter_national_number =>
      'Please enter your national number';

  @override
  String get national_number_atleast => 'National number must be 11 digits';

  @override
  String get delete_complaint_done => 'Complaint deleted successfully';

  @override
  String get not_found_history => 'No history yet for this complaint.';

  @override
  String get info_sent_success => 'Additional information sent successfully';

  @override
  String get logout_error => 'An error occurred while logging out';

  @override
  String get complaint_sent => 'Complaint submitted successfully';

  @override
  String get download_agency => 'Loading agencies...';

  @override
  String get download_types => 'Loading complaint types...';

  @override
  String get otp_invalid_6_digits => 'Enter the 6-digit code';

  @override
  String get photos_selected => 'Selected photos';

  @override
  String get common_skip => 'Skip';

  @override
  String get tour_settings_title => 'Settings icon';

  @override
  String get tour_settings_desc =>
      'Here you can manage your application in terms of language and theme selection, and log out if you wish.';

  @override
  String get tour_add_complaint_title => 'Submit a complaint';

  @override
  String get tour_add_complaint_desc =>
      'Here you can submit the complaint you are facing, add a new complaint to your complaint log, and track the status of each complaint by clicking on it and viewing its details.';

  @override
  String get tour_notifications_title => 'Notifications icon';

  @override
  String get tour_notifications_desc =>
      'Here you can see all your notifications';
}
