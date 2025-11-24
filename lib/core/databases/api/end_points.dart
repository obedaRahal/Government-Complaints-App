class EndPoints {
  /// عدّل الـ baseUrl حسب الـ API تبعك
  static const String baseUrl = 'http://localhost/api/v1/';

  static const String registerCitizen = 'citizen/register';
  static const String verifyRegisterCode = 'citizen/verifyAccount';
  static const String resendVerifyCode = 'citizen/resendOtp';
  static const String forgotPasswordEmail = 'citizen/forgotPassword';
  static const String verifyForgotPasswordEmail =
      'citizen/verifyForgotPasswordEmail';
  static const String resendPasswordResetOtp = 'citizen/resendPasswordResetOtp';
  static const String resetPassword = 'citizen/resetPassword';
  static const String loginCitizen = 'citizen/login';
}
