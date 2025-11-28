import '../../domain/entities/complaint_entity.dart';

class ComplaintModel extends ComplaintEntity {
  const ComplaintModel({
    required super.id,
    required super.title,
    required super.description,
    required super.number,
    required super.currentStatus,
    required super.createdAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      number: json['number'] as int,
      currentStatus: json['current_status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
