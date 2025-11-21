import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_register_state.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  Timer? _timer;

  VerifyRegisterCubit() : super(const VerifyRegisterState()) {
    _startTimer();
  }

  void _startTimer() {
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

  void otpChanged(String value) {
    emit(state.copyWith(otpCode: value, isSuccess: false, errorMessage: null));
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
      _timer?.cancel();
  }

  void resendCode() {
    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
