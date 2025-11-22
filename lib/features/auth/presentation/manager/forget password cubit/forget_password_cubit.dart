import 'dart:async';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  Timer? _timer;

  ForgotPasswordCubit() : super(const ForgotPasswordState());
  void resetStatus() {
    emit(
      state.copyWith(
        otpCode: '',
        isSuccess: false,
        isSubmitting: false,
        errorMessage: null,
      ),
    );
  }

  // ---------------------------
  //  Step 1: Email
  // ---------------------------
  void emailChanged(String value) {
    emit(state.copyWith(email: value, errorMessage: null, isSuccess: false));
  }

  Future<void> submitEmail() async {
    if (state.email.isEmpty || !state.email.contains('@')) {
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال بريد صحيح',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false),
    );

    // محاكاة إرساله للسيرفر
    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        isSubmitting: false,
        isSuccess: true, // سينقلك للخطوة التالية
      ),
    );
  }

  // ---------------------------
  //  Step 2: OTP
  // ---------------------------

  void startTimer() {
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: 300));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        emit(state.copyWith(remainingSeconds: 0));
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  void resendCode() {
    startTimer();
    emit(
      state.copyWith(
        otpCode: '',
        isSubmitting: false,
        isSuccess: false,
        errorMessage: null,
      ),
    );
  }

  void otpChanged(String value) {
    emit(state.copyWith(otpCode: value, errorMessage: null, isSuccess: false));
  }

  Future<void> submitOtp() async {
    if (state.otpCode.length != 6) {
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال الرمز المؤلف من 6 أرقام',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false),
    );

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isSubmitting: false, isSuccess: true));

    _timer?.cancel(); // مهم: وقف التايمر عند النجاح
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  // ---------------------------
  //  Step 3: New Password
  // ---------------------------
  void newPasswordChanged(String value) {
    emit(
      state.copyWith(newPassword: value, errorMessage: null, isSuccess: false),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        errorMessage: null,
        isSuccess: false,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        isPasswordObscure: !state.isPasswordObscure,
      ),
    );
  }


  Future<void> submitNewPassword() async {
    if (state.newPassword.length < 6) {
      emit(
        state.copyWith(
          errorMessage: 'كلمة المرور يجب أن تكون ٦ أحرف على الأقل',
          isSuccess: false,
        ),
      );
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      emit(state.copyWith(errorMessage: 'كلمتا المرور غير متطابقتين'));
      return;
    }

    emit(
      state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false),
    );

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isSubmitting: false, isSuccess: true));
  }
}
