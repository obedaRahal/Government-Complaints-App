import 'package:complaints_app/features/home/domain/use_cases/get_complaints_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/complaint_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getComplaintsUseCase) : super(const HomeState()) {
    debugPrint("============ HomeCubit INIT ============");
     loadComplaints();
  }

  final GetComplaintsUseCase _getComplaintsUseCase;

  Future<void> loadComplaints({int page = 1, int perPage = 10}) async {
    debugPrint("============ HomeCubit.loadComplaints ============");
    debugPrint(
      "loadComplaints -> last page: ${state.lastPage}, per page: ${state.perPage}",
    );
    emit(state.copyWith(status: HomeStatusEnum.loading));

    final result = await _getComplaintsUseCase(
      GetComplaintsParams(page: page, perPage: perPage),
    );

    result.fold(
      (failure) {
        debugPrint("loadComplaints -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: HomeStatusEnum.error,
            message: failure.errMessage,
          ),
        );
      },
      (data) {
        debugPrint("loadComplaints -> SUCCESS: ${data.complaints}");

        emit(
          state.copyWith(
            status: HomeStatusEnum.success,
            complaints: data.complaints,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            perPage: data.meta.perPage,
          ),
        );
      },
    );
  }

  Future<void> loadMoreComplaints() async {
    if (!state.canLoadMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = await _getComplaintsUseCase(
      GetComplaintsParams(page: nextPage, perPage: state.perPage),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, message: failure.errMessage),
      ),
      (data) {
        final newList = [...state.complaints, ...data.complaints];

        emit(
          state.copyWith(
            complaints: newList,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
