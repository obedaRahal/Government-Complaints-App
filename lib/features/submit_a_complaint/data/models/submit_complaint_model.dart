import 'package:complaints_app/features/submit_a_complaint/domain/entities/submit_complaint_entity.dart';

class SubmitComplaintModel {
  final String successMessage;
  final int statusCode;

  const SubmitComplaintModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory SubmitComplaintModel.fromJson(Map<String, dynamic> json) {
    return SubmitComplaintModel(
      successMessage: json['successMessage'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  SubmitComplaintEntity toEntity() {
    return SubmitComplaintEntity(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}