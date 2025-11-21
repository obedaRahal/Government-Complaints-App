
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());
void nameChanged(String value) {
  emit(state.copyWith(
    name: value,
    isSuccess: false,
    errorMessage: null,
  ));
}

void emailChanged(String value) {
  emit(state.copyWith(
    email: value,
    isSuccess: false,
    errorMessage: null,
  ));
}

void idNumberChanged(String value) {
  emit(state.copyWith(
    idNumber: value,
    isSuccess: false,
    errorMessage: null,
  ));
}

void passwordChanged(String value) {
  emit(state.copyWith(
    password: value,
    isSuccess: false,
    errorMessage: null,
  ));
}

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  Future<void> registerSubmitted() async {
    debugPrint("im at registerSubmitted ");

    emit(
      state.copyWith(isSubmitting: true, errorMessage: null, isSuccess: false),
    );
    debugPrint("im at registerSubmitted after loading");

    await Future.delayed(const Duration(seconds: 1));

    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.idNumber.isEmpty ||
        state.password.isEmpty) {
      debugPrint("im at registerSubmitted emptyyy vallll");
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'الرجاء إدخال كل الحقول',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(isSubmitting: false, errorMessage: null, isSuccess: true),
    );
    debugPrint("im at registerSubmitted and successssss");

  }
}
