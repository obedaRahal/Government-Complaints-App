import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/delete_complaint_use_case.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/get_complaint_details_use_case.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/params/get_complaint_details_params.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintDetailsCubit extends Cubit<ComplaintDetailsState> {
  final GetComplaintDetailsUseCase getComplaintDetailsUseCase;
  final DeleteComplaintUseCase deleteComplaintUseCase;

  ComplaintDetailsCubit(
    this.getComplaintDetailsUseCase,
    this.deleteComplaintUseCase,
  ) : super(const ComplaintDetailsState());

  Future<void> loadComplaintDetails(int complaintId) async {
    if (isClosed) return;
    debugPrint(
      "ComplaintDetailsCubit.loadComplaintDetails -> id: $complaintId",
    );

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getComplaintDetailsUseCase(
      GetComplaintDetailsParams(complaintId: complaintId),
    );
    if (isClosed) return;

    result.fold(
      (Failure failure) {
        debugPrint("ComplaintDetailsCubit FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.errMessage),
        );
      },
      (detailsEntity) {
        debugPrint("ComplaintDetailsCubit SUCCESS, got details");
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            details: detailsEntity,
          ),
        );
      },
    );
  }

  Future<void> refresh(int complaintId) async {
    await loadComplaintDetails(complaintId);
  }

  Future<void> deleteComplaint(int complaintId) async {
    if (isClosed) return;
    emit(
      state.copyWith(
        isDeleting: true,
        deleteErrorMessage: null,
        deleteSuccessMessage: null,
        isDeleteSuccess: false,
      ),
    );

    final result = await deleteComplaintUseCase(complaintId);
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isDeleting: false,
            deleteErrorMessage: failure.errMessage,
            deleteSuccessMessage: null,
            isDeleteSuccess: false,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            isDeleting: false,
            deleteErrorMessage: null,
            deleteSuccessMessage: response.successMessage,
            isDeleteSuccess: true,
          ),
        );
      },
    );
  }
}
