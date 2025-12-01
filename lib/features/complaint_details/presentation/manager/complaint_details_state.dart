import 'package:equatable/equatable.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';

class ComplaintDetailsState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final ComplaintDetailsEntity? details;
  final bool isDeleting;
  final String? deleteErrorMessage;
  final String? deleteSuccessMessage;
  final bool isDeleteSuccess;

  const ComplaintDetailsState({
    this.isLoading = false,
    this.errorMessage,
    this.details,
    this.isDeleting = false,
    this.deleteErrorMessage,
    this.deleteSuccessMessage,
    this.isDeleteSuccess = false,
  });

  bool get hasData => details != null;

  ComplaintDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    ComplaintDetailsEntity? details,
    bool? isDeleting,
    String? deleteErrorMessage,
    String? deleteSuccessMessage,
    bool? isDeleteSuccess,
  }) {
    return ComplaintDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      details: details ?? this.details,
      isDeleting: isDeleting ?? this.isDeleting,
      deleteErrorMessage: deleteErrorMessage,
      deleteSuccessMessage: deleteSuccessMessage,
      isDeleteSuccess: isDeleteSuccess ?? this.isDeleteSuccess,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    details,
    isDeleting,
    deleteErrorMessage,
    deleteSuccessMessage,
    isDeleteSuccess,
  ];
}
