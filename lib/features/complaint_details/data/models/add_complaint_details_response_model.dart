import '../../domain/entities/add_complaint_details_response_entity.dart';

class AddComplaintDetailsResponseModel
    extends AddComplaintDetailsResponseEntity {
  const AddComplaintDetailsResponseModel({
    required super.successMessage,
    required super.statusCode,
  });

  factory AddComplaintDetailsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
   return AddComplaintDetailsResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode'].toString()) ?? 0,
    );
  }
}
