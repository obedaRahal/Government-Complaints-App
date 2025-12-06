import 'package:complaints_app/features/complaint_details/domain/use_case/add_complaint_details_use_case.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/params/add_complaint_details_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'add_details_state.dart';
import 'package:flutter/foundation.dart';

class AddDetailsCubit extends Cubit<AddDetailsState> {
  final AddComplaintDetailsUseCase addComplaintDetailsUseCase;
final descriptionController = TextEditingController();
  AddDetailsCubit(this.addComplaintDetailsUseCase)
      : super(const AddDetailsState());

  void extraTextChanged(String value) {
    emit(
      state.copyWith(
        extraText: value,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );
  }

  void setExtraAttachments(List<ImageFile> images) {
    emit(
      state.copyWith(
        extraAttachments: images,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );
  }

  Future<void> submit(int complaintId) async {
   debugPrint("===== AddDetailsCubit.submit START =====");
  debugPrint("complaintId: $complaintId");
  debugPrint("extraText: ${state.extraText}");
  debugPrint("attachments count: ${state.extraAttachments.length}");
  debugPrint("submit -> attachmentPaths: ${state.extraAttachments.map((e) => e.path).toList()}");
    if (state.extraText.trim().isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال وصف إضافي',
          isSuccess: false,
        ),
      );
      debugPrint("submit -> validation failed: empty extraText");
      return;
    }

    final attachmentPaths = state.extraAttachments
        .map((img) => img.path)
        .whereType<String>()
        .toList();

    debugPrint("submit -> attachmentPaths: $attachmentPaths");

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final params = AddComplaintDetailsParams(
      complaintId: complaintId,
      extraText: state.extraText,
      attachmentPaths: attachmentPaths,
    );

    final result = await addComplaintDetailsUseCase(params);

    result.fold(
      (failure) {
        debugPrint(
          "AddDetailsCubit.submit FAILURE: ${failure.errMessage}",
        );
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
          "AddDetailsCubit.submit SUCCESS: ${response.successMessage}",
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

    debugPrint("===== AddDetailsCubit.submit END =====");
  }

  void reset() {
    emit(const AddDetailsState());
  }
}
