import 'package:complaints_app/features/complaint_details/domain/entities/complaint_attachment_entity.dart';

class ComplaintAttachmentModel {
  final int id;
  final String path;

  ComplaintAttachmentModel({
    required this.id,
    required this.path,
  });

  factory ComplaintAttachmentModel.fromJson(Map<String, dynamic> json) {
    return ComplaintAttachmentModel(
      id: json['id'] as int,
      path: json['path'] as String,
    );
  }

  ComplaintAttachmentEntity toEntity() {
    return ComplaintAttachmentEntity(
      id: id,
      path: path,
    );
  }
}
