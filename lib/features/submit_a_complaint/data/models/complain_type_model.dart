import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';

class ComplaintTypeModel {
  final int id;
  final String name;

  const ComplaintTypeModel({
    required this.id,
    required this.name,
  });

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  ComplaintTypeEntity toEntity() {
    return ComplaintTypeEntity(
      id: id,
      name: name,
    );
  }
}
