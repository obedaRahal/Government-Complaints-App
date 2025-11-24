import 'dart:async';
import 'package:complaints_app/features/auth/domain/use_cases/foget_password_email_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/forget_password_email_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/forget_password_verify_otp_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/reset_password_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_password_reset_otp_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_forget_password_use_case.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final FogretPasswordEmailUseCase forgetPasswordEmailUseCase;
  final VerifyForgetPasswordUseCase verifyForgotPasswordOtpUseCase;
  final ResendPasswordResetOtpUseCase resendPasswordResetOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase ;
  Timer? _timer;

  ForgotPasswordCubit({
    required this.forgetPasswordEmailUseCase,
    required this.resendPasswordResetOtpUseCase,
    required this.verifyForgotPasswordOtpUseCase,
    required this.resetPasswordUseCase,
  }) : super(const ForgotPasswordState()) {
    debugPrint("============ ForgotPasswordCubit INIT ============");
  }

  void resetStatus() {
    debugPrint("ForgotPasswordCubit.resetStatus()");
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
    debugPrint("ForgotPasswordCubit.emailChanged -> $value");
    emit(state.copyWith(email: value, errorMessage: null, isSuccess: false));
  }

  Future<void> submitEmail() async {
    debugPrint("============ ForgotPasswordCubit.submitEmail ============");
    debugPrint("submitEmail -> email: ${state.email}");

    if (state.email.isEmpty || !state.email.contains('@')) {
      debugPrint("submitEmail -> invalid email");
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال بريد صحيح',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await forgetPasswordEmailUseCase(
      ForgetPasswordEmailParams(email: state.email),
    );

    result.fold(
      (failure) {
        debugPrint("submitEmail -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (response) {
        debugPrint("submitEmail -> SUCCESS: ${response.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess: true, // هذا اللي ينقلك للـ OTP
          ),
        );
      },
    );
    debugPrint("============ submitEmail END ============");
  }

  // ---------------------------
  //  Step 2: OTP
  // ---------------------------

  void startTimer() {
    debugPrint("ForgotPasswordCubit.startTimer() -> reset to 300s");
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: 300));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        debugPrint("ForgotPasswordCubit timer finished (0s left)");
        timer.cancel();
        emit(state.copyWith(remainingSeconds: 0));
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  Future<void> resendCode() async {
    debugPrint("============ ForgotPasswordCubit.resendCode ============");
    debugPrint("resendCode -> email: ${state.email}");

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await resendPasswordResetOtpUseCase(state.email);

    result.fold(
      (failure) {
        debugPrint("resendCode -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (response) {
        debugPrint(
          "resendCode -> SUCCESS: ${response.successMessage}, restart timer",
        );
        startTimer(); // 👈 نعيد تشغيل التايمر

        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess: false,
            otpCode: '',
          ),
        );
      },
    );
    debugPrint("============ resendCode END ============");
  }

  void otpChanged(String value) {
    debugPrint("ForgotPasswordCubit.otpChanged -> $value");
    emit(state.copyWith(otpCode: value, errorMessage: null, isSuccess: false));
  }

  Future<void> submitOtp() async {
    debugPrint("============ ForgotPasswordCubit.submitOtp ============");
    debugPrint("submitOtp -> otp: ${state.otpCode}");

    if (state.otpCode.length != 6) {
      debugPrint(
        "submitOtp -> invalid otp length: ${state.otpCode.length} (must be 6)",
      );
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال الرمز المؤلف من 6 أرقام',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await verifyForgotPasswordOtpUseCase(
      VerifyForgetPasswordOtpParams(email: state.email, otpCode: state.otpCode),
    );

    result.fold(
      (failure) {
        debugPrint("submitOtp -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (response) {
        debugPrint("submitOtp -> SUCCESS: ${response.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess:
                true, // 👈 هذا هو النجاح اللي ينقلك لصفحة الباسورد الجديدة
          ),
        );
        _timer?.cancel();
      },
    );
    debugPrint("============ submitOtp END ============");
  }

  @override
  Future<void> close() {
    debugPrint("ForgotPasswordCubit.close() -> cancel timer & dispose");
    _timer?.cancel();
    return super.close();
  }



  // ---------------------------
  //  Step 3: New Password
  // ---------------------------
  void newPasswordChanged(String value) {
    debugPrint(
      "ForgotPasswordCubit.newPasswordChanged -> (length: ${value.length})",
    );
    emit(
      state.copyWith(newPassword: value, errorMessage: null, isSuccess: false),
    );
  }

  void confirmPasswordChanged(String value) {
    debugPrint(
      "ForgotPasswordCubit.confirmPasswordChanged -> (length: ${value.length})",
    );
    emit(
      state.copyWith(
        confirmPassword: value,
        errorMessage: null,
        isSuccess: false,
      ),
    );
  }

  void togglePasswordVisibility() {
    debugPrint(
      "ForgotPasswordCubit.togglePasswordVisibility -> ${!state.isPasswordObscure}",
    );
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  Future<void> submitNewPassword() async {
    debugPrint(
      "============ ForgotPasswordCubit.submitNewPassword ============",
    );
    debugPrint(
      "submitNewPassword -> newPassword length: ${state.newPassword.length}, confirmPassword length: ${state.confirmPassword.length}",
    );

    if (state.newPassword.length < 6) {
      debugPrint("submitNewPassword -> password too short");
      emit(
        state.copyWith(
          errorMessage: 'كلمة المرور يجب أن تكون ٦ أحرف على الأقل',
          isSuccess: false,
        ),
      );
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      debugPrint("submitNewPassword -> passwords not match");
      emit(
        state.copyWith(
          errorMessage: 'كلمتا المرور غير متطابقتين',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await resetPasswordUseCase(
      ResetPasswordParams(
        email: state.email,
        password: state.newPassword,
        passwordConfirmation: state.confirmPassword,
      ),
    );

    result.fold(
      (failure) {
        debugPrint("submitNewPassword -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (response) {
        debugPrint(
          "submitNewPassword -> SUCCESS: ${response.successMessage}",
        );
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess: true,
          ),
        );
      },
    );

    debugPrint(
      "============ ForgotPasswordCubit.submitNewPassword END ============",
    );
  }

}
