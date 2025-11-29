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
    emit(
      state.copyWith(
        isLoadingComplaintTypes: true,
        complaintTypesErrorMessage: null,
      ),
    );
    final resultComplaintTypes = await getComplaintTypeUseCase();
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

  // 1) تحميل الجهات الحكومية من الـ API
  Future<void> loadAgencies() async {
    emit(state.copyWith(isLoadingAgencies: true, agenciesErrorMessage: null));

    final resultAgencies = await getAgenciesUseCase();

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

    // 1) تحقق بسيط من الحقول المطلوبة
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

    // 2) تجهيز مسارات الصور من الـ ImageFile
    final attachmentPaths = state.attachments
        .map((img) => img.path)
        .whereType<String>()
        .toList();

    debugPrint("submitComplaint -> attachments count: ${attachmentPaths.length}");

    // 3) حالة الـ loading
    emit(
      state.copyWith(
        isSubmitting: true,
        submitErrorMessage: null,
        submitSuccessMessage: null,
        isSubmitSuccess: false,
      ),
    );

    // 4) استدعاء الـ UseCase
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
        debugPrint(
          "submitComplaint SUCCESS: ${response.successMessage}",
        );
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


  // 2) اختيار نوع الشكوى
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

  // 3) اختيار الجهة الحكومية من الـ dropdown
  void selectGovEntity(String? name) {
    if (name == null) {
      emit(state.copyWith(selectedAgencyId: null, selectedAgencyName: null));
      return;
    }

    // نبحث عن الـ AgencyEntity الذي يحمل هذا الاسم
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

  // 4) المرفقات
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
        // اختيار نوع الشكوى
        selectedComplaintTypeId: null,
        selectedComplaintTypeName: null,

        // اختيار الجهة الحكومية
        selectedAgencyId: null,
        selectedAgencyName: null,

        // حقول النص
        title: '',
        description: '',
        locationText: '',

        // المرفقات
        attachments: [],

        // حالة الإرسال
        isSubmitting: false,
        submitErrorMessage: null,
        submitSuccessMessage: null,
        isSubmitSuccess: false,
      ),
    );
  }

}
