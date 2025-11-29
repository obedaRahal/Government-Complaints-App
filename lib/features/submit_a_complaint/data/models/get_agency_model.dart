import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';

class AgencyModel {
  final int id;
  final String name;

  const AgencyModel({
    required this.id,
    required this.name,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    return AgencyModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  AgencyEntity toEntity() {
    return AgencyEntity(
      id: id,
      name: name,
    );
  }
}
