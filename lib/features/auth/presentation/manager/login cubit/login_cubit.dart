import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_state.dart' show LoginState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        isPasswordObscure: !state.isPasswordObscure,
      ),
    );
  }

  Future<void> loginSubmitted() async {
    debugPrint("im at loginSubmitted ");

    emit(state.copyWith(
      isSubmitting: true,
      errorMessage: null,
      isSuccess: false,
    ));
    debugPrint("im at loginSubmitted after loading");

    // 2) هنا مؤقتاً نعمل تأخير بسيط كأنو عم نكلم السيرفر
    await Future.delayed(const Duration(seconds: 1));

    // 3) تحقق بسيط جداً مبدئي (فقط كمثال)
    if (state.email.isEmpty || state.password.isEmpty) {
      debugPrint("im at loginSubmitted emptyyy vallll");
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'الرجاء إدخال البريد وكلمة المرور',
        isSuccess: false,
      ));
      return;
    }

    // 4) لو كل شيء تمام (مؤقتاً نعتبره نجاح)
    emit(state.copyWith(
      isSubmitting: false,
      errorMessage: null,
      isSuccess: true,
    ));
    debugPrint("im at loginSubmitted and successssss");

    // لاحقاً: هون ممكن نطلق state ثانية أو نستخدم BlocListener للتنقل للهوم
  }
}