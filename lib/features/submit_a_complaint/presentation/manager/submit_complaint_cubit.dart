import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/get_agency_use_case.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/get_complaint_type_use_case.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/params/submit_complaint_params.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/submit_complaint_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'submit_complaint_state.dart';

class SubmitComplaintCubit extends Cubit<SubmitComplaintState> {
  final GetAgenciesUseCase getAgenciesUseCase;
  final GetComplaintTypeUseCase getComplaintTypeUseCase;
  final SubmitComplaintUseCase submitComplaintUseCase;
  final descriptionController = TextEditingController();

  SubmitComplaintCubit(
    this.getAgenciesUseCase,
    this.getComplaintTypeUseCase,
    this.submitComplaintUseCase,
  ) : super(const SubmitComplaintState(complaintTypes: [], agencies: []));
  Future<void> loadComplaintType() async {
    if (isClosed) return;
    emit(
      state.copyWith(
        isLoadingComplaintTypes: true,
        complaintTypesErrorMessage: null,
      ),
    );
    final resultComplaintTypes = await getComplaintTypeUseCase();
    if (isClosed) return;
    resultComplaintTypes.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoadingComplaintTypes: false,
            complaintTypesErrorMessage: failure.errMessage,
          ),
        );
      },
      (complaintTypes) {
        emit(
          state.copyWith(
            isLoadingComplaintTypes: false,
            complainTypes: complaintTypes,
          ),
        );
      },
    );
  }

  Future<void> loadAgencies() async {
    if (isClosed) return;
    emit(state.copyWith(isLoadingAgencies: true, agenciesErrorMessage: null));

    final resultAgencies = await getAgenciesUseCase();
    if (isClosed) return;
    resultAgencies.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoadingAgencies: false,
            agenciesErrorMessage: failure.errMessage,
          ),
        );
      },
      (agencies) {
        emit(state.copyWith(isLoadingAgencies: false, agencies: agencies));
      },
    );
  }

  Future<void> submitComplaint() async {
    debugPrint("===== SubmitComplaintCubit.submitComplaint START =====");

    if (state.selectedAgencyId == null) {
      emit(
        state.copyWith(
          submitErrorMessage: 'الرجاء اختيار الجهة الحكومية',
          isSubmitSuccess: false,
        ),
      );
      return;
    }

    if (state.selectedComplaintTypeId == null) {
      emit(
        state.copyWith(
          submitErrorMessage: 'الرجاء اختيار نوع الشكوى',
          isSubmitSuccess: false,
        ),
      );
      return;
    }

    if (state.title.trim().isEmpty ||
        state.description.trim().isEmpty ||
        state.locationText.trim().isEmpty) {
      emit(
        state.copyWith(
          submitErrorMessage: 'الرجاء تعبئة جميع حقول الشكوى',
          isSubmitSuccess: false,
        ),
      );
      return;
    }

    final attachmentPaths = state.attachments
        .map((img) => img.path)
        .whereType<String>()
        .toList();

    debugPrint(
      "submitComplaint -> attachments count: ${attachmentPaths.length}",
    );

    emit(
      state.copyWith(
        isSubmitting: true,
        submitErrorMessage: null,
        submitSuccessMessage: null,
        isSubmitSuccess: false,
      ),
    );

    final params = SubmitComplaintParams(
      agencyId: state.selectedAgencyId!,
      complaintTypeId: state.selectedComplaintTypeId!,
      title: state.title,
      description: state.description,
      locationText: state.locationText,
      attachmentPaths: attachmentPaths,
    );

    final result = await submitComplaintUseCase(params);

    result.fold(
      (failure) {
        debugPrint("submitComplaint FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            submitErrorMessage: failure.errMessage,
            submitSuccessMessage: null,
            isSubmitSuccess: false,
          ),
        );
      },
      (response) {
        debugPrint("submitComplaint SUCCESS: ${response.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            submitErrorMessage: null,
            submitSuccessMessage: response.successMessage,
            isSubmitSuccess: true,
          ),
        );
      },
    );

    debugPrint("===== SubmitComplaintCubit.submitComplaint END =====");
  }

  @override
  Future<void> close() {
    descriptionController.dispose();
    return super.close();
  }

  void selectComplaintTypeEntity(String? name) {
    if (name == null) {
      emit(
        state.copyWith(
          selectedComplaintTypeId: null,
          selectedComplaintTypeName: null,
        ),
      );
      return;
    }
    ComplaintTypeEntity? selectedType;
    for (final complaintType in state.complaintTypes) {
      if (complaintType.name == name) {
        selectedType = complaintType;
        break;
      }
    }
    emit(
      state.copyWith(
        selectedComplaintTypeId: selectedType?.id,
        selectedComplaintTypeName: name,
      ),
    );
  }

  void selectGovEntity(String? name) {
    if (name == null) {
      emit(state.copyWith(selectedAgencyId: null, selectedAgencyName: null));
      return;
    }

    AgencyEntity? selected;
    for (final agency in state.agencies) {
      if (agency.name == name) {
        selected = agency;
        break;
      }
    }

    emit(
      state.copyWith(selectedAgencyName: name, selectedAgencyId: selected?.id),
    );
  }

  void setAttachments(List<ImageFile> images) {
    emit(state.copyWith(attachments: images));
  }

  void titleChanged(String value) {
    emit(
      state.copyWith(
        title: value,
        submitErrorMessage: null,
        isSubmitSuccess: false,
      ),
    );
  }

  void descriptionChanged(String value) {
    emit(
      state.copyWith(
        description: value,
        submitErrorMessage: null,
        isSubmitSuccess: false,
      ),
    );
  }

  void locationChanged(String value) {
    emit(
      state.copyWith(
        locationText: value,
        submitErrorMessage: null,
        isSubmitSuccess: false,
      ),
    );
  }

  void resetForm() {
    emit(
      state.copyWith(
        selectedComplaintTypeId: null,
        selectedComplaintTypeName: null,

        selectedAgencyId: null,
        selectedAgencyName: null,

        title: '',
        description: '',
        locationText: '',

        attachments: [],

        isSubmitting: false,
        submitErrorMessage: null,
        submitSuccessMessage: null,
        isSubmitSuccess: false,
      ),
    );
  }
}
