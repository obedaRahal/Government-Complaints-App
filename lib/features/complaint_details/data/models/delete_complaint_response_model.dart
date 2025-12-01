import 'package:complaints_app/features/complaint_details/domain/entities/delete_complaint_response.dart';

class DeleteComplaintResponseModel {
  final String successMessage;
  final int statusCode;

  DeleteComplaintResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory DeleteComplaintResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteComplaintResponseModel(
      successMessage: json['successMessage'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  DeleteComplaintResponseEntity toEntity() {
    return DeleteComplaintResponseEntity(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
