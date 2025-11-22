class ForgotPasswordState {
  final String email;
  final String otpCode;
  final String newPassword;
  final String confirmPassword;

  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  final int remainingSeconds;

    final bool isPasswordObscure;


  const ForgotPasswordState({
    this.email = '',
    this.otpCode = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
    this.remainingSeconds = 300,
    this.isPasswordObscure = true
  });

  bool get isTimerFinished => remainingSeconds <= 0;

  ForgotPasswordState copyWith({
    String? email,
    String? otpCode,
    String? newPassword,
    String? confirmPassword,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
    int? remainingSeconds,
    bool? isPasswordObscure
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
