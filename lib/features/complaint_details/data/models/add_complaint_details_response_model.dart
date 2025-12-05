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
      successMessage: json['successMessage'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
