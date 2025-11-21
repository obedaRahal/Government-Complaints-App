
class LoginState {
  final String email;
  final String password;
  final bool isSubmitting; //////for loadingggggggggg
  final String? errorMessage;
  final bool isSuccess;
    final bool isPasswordObscure;



  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess =false , 
    this.isPasswordObscure=true
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
    bool? isPasswordObscure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
