import 'package:complaints_app/features/complaint_details/domain/entities/complaint_info_entity.dart';

class ComplaintInfoModel {
  final String complaintType;
  final String agency;
  final int complaintNumber;
  final String title;
  final String description;
  final String status;
  final String locationText;
  final String createdAt;

  ComplaintInfoModel({
    required this.complaintType,
    required this.agency,
    required this.complaintNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.locationText, required this.createdAt,
  });

  factory ComplaintInfoModel.fromJson(Map<String, dynamic> json) {
    return ComplaintInfoModel(
      complaintType: json['complaint_type'] as String,
      agency: json['agency'] as String,
      complaintNumber: json['complaint_number'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      locationText: json['location_text'] as String,
      createdAt: json['created_at'] as String? ??
          '', 
    );
  }

  ComplaintInfoEntity toEntity() {
    return ComplaintInfoEntity(
      complaintType: complaintType,
      agency: agency,
      complaintNumber: complaintNumber,
      title: title,
      description: description,
      status: status,
      locationText: locationText,
      createdAt: createdAt,
    );
  }
}
