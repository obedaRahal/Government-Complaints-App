import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class SubmitComplaintState extends Equatable {
  final int? selectedComplaintTypeId;
  final String? selectedComplaintTypeName;
  final List<ComplaintTypeEntity> complaintTypes;

  final int? selectedAgencyId;
  final String? selectedAgencyName;
  final List<AgencyEntity> agencies;

  final bool isLoadingAgencies;
  final bool isLoadingComplaintTypes;
  final String? agenciesErrorMessage;
  final String? complaintTypesErrorMessage;

  // 📌 حقول الشكوى نفسها
  final String title;
  final String description;
  final String locationText;

  // حالة إرسال الشكوى
  final bool isSubmitting;
  final String? submitErrorMessage;
  final String? submitSuccessMessage;
  final bool isSubmitSuccess;

  final List<ImageFile> attachments;

  const SubmitComplaintState({
    this.selectedAgencyId,
    this.selectedAgencyName,
    this.selectedComplaintTypeId,
    this.selectedComplaintTypeName,
    this.agencies = const [],
    this.complaintTypes = const [],
    this.isLoadingAgencies = false,
    this.isLoadingComplaintTypes = false,
    this.agenciesErrorMessage,
    this.complaintTypesErrorMessage,
    this.title = '',
    this.description = '',
    this.locationText = '',
    this.isSubmitting = false,
    this.submitErrorMessage,
    this.submitSuccessMessage,
    this.isSubmitSuccess = false,
    this.attachments = const [],
    // this.title,
    // this.description,
    // this.locationText,
    // this.isSubmitting,
    // this.submitErrorMessage,
    // this.submitSuccessMessage,
    // this.isSubmitSuccess, {
    // this.selectedAgencyId,
    // this.selectedAgencyName,
    // this.selectedComplaintTypeId,
    // this.selectedComplaintTypeName,
    // this.agencies = const [],
    // this.complaintTypes = const [],
    // this.isLoadingAgencies = false,
    // this.isLoadingComplaintTypes = false,
    // this.agenciesErrorMessage,
    // this.complaintTypesErrorMessage,
    // this.attachments = const [],
  });

  SubmitComplaintState copyWith({
     int? selectedAgencyId,
    int? selectedComplaintTypeId,
    String? selectedAgencyName,
    String? selectedComplaintTypeName,
    List<AgencyEntity>? agencies,
    List<ComplaintTypeEntity>? complainTypes,
    bool? isLoadingAgencies,
    bool? isLoadingComplaintTypes,
    String? agenciesErrorMessage,
    String? complaintTypesErrorMessage,
    String? title,
    String? description,
    String? locationText,
    bool? isSubmitting,
    String? submitErrorMessage,
    String? submitSuccessMessage,
    bool? isSubmitSuccess,
    List<ImageFile>? attachments,
  }) {
   return SubmitComplaintState(
      selectedAgencyId: selectedAgencyId ?? this.selectedAgencyId,
      selectedComplaintTypeId:
          selectedComplaintTypeId ?? this.selectedComplaintTypeId,
      selectedAgencyName: selectedAgencyName ?? this.selectedAgencyName,
      selectedComplaintTypeName:
          selectedComplaintTypeName ?? this.selectedComplaintTypeName,
      agencies: agencies ?? this.agencies,
      complaintTypes: complainTypes ?? this.complaintTypes,
      isLoadingAgencies: isLoadingAgencies ?? this.isLoadingAgencies,
      isLoadingComplaintTypes:
          isLoadingComplaintTypes ?? this.isLoadingComplaintTypes,
      agenciesErrorMessage: agenciesErrorMessage ?? this.agenciesErrorMessage,
      complaintTypesErrorMessage:
          complaintTypesErrorMessage ?? this.complaintTypesErrorMessage,
      title: title ?? this.title,
      description: description ?? this.description,
      locationText: locationText ?? this.locationText,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitErrorMessage: submitErrorMessage,
      submitSuccessMessage: submitSuccessMessage,
      isSubmitSuccess: isSubmitSuccess ?? this.isSubmitSuccess,
      attachments: attachments ?? this.attachments,
    );
  }

@override
  List<Object?> get props => [
        complaintTypes,
        selectedAgencyId,
        selectedAgencyName,
        selectedComplaintTypeId,
        selectedComplaintTypeName,
        agencies,
        isLoadingAgencies,
        isLoadingComplaintTypes,
        agenciesErrorMessage,
        complaintTypesErrorMessage,
        title,
        description,
        locationText,
        isSubmitting,
        submitErrorMessage,
        submitSuccessMessage,
        isSubmitSuccess,
        attachments,
      ];
}
