class LoginParams {
  final String email;
  final String password;
  final String? fcmToken;

  LoginParams({required this.email, required this.password , this.fcmToken});
}
