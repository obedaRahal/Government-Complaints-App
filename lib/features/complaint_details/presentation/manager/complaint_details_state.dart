import 'package:equatable/equatable.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';

class ComplaintDetailsState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final ComplaintDetailsEntity? details;

  const ComplaintDetailsState({
    this.isLoading = false,
    this.errorMessage,
    this.details,
  });

  bool get hasData => details != null;

  ComplaintDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    ComplaintDetailsEntity? details,
  }) {
    return ComplaintDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, details];
}
