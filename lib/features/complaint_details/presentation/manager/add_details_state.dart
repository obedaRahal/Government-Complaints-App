import 'package:equatable/equatable.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class AddDetailsState extends Equatable {
  final String extraText;
  final List<ImageFile> extraAttachments;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const AddDetailsState({
    this.extraText = '',
    this.extraAttachments = const [],
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  AddDetailsState copyWith({
    String? extraText,
    List<ImageFile>? extraAttachments,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
  }) {
    return AddDetailsState(
      extraText: extraText ?? this.extraText,
      extraAttachments: extraAttachments ?? this.extraAttachments,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        extraText,
        extraAttachments,
        isSubmitting,
        isSuccess,
        errorMessage,
        successMessage,
      ];
}
