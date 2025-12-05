import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/complaint_details/data/models/add_complaint_details_response_model.dart';
import 'package:complaints_app/features/complaint_details/data/models/complaint_details_model.dart';
import 'package:complaints_app/features/complaint_details/data/models/delete_complaint_response_model.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/params/add_complaint_details_params.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ComplaintDetailsRemoteDataSource {
  Future<ComplaintDetailsModel> getComplaintDetails(int complaintId);
  Future<DeleteComplaintResponseModel> deleteComplaint(int id);
  Future<AddComplaintDetailsResponseModel> addComplaintDetails(
    AddComplaintDetailsParams params,
  );
}

class ComplaintDetailsRemoteDataSourceImpl
    implements ComplaintDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ComplaintDetailsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<ComplaintDetailsModel> getComplaintDetails(int complaintId) async {
    debugPrint(
      "ComplaintDetailsRemoteDataSourceImpl.getComplaintDetails -> id: $complaintId",
    );


    final response = await apiConsumer.get(
      "${EndPoints.complaintDetails}$complaintId",
    );

    return ComplaintDetailsModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<DeleteComplaintResponseModel> deleteComplaint(int id) async {
    final response = await apiConsumer.delete(
      '${EndPoints.deleteComplaint}/$id',
    );
    return DeleteComplaintResponseModel.fromJson(response);
  }

  @override
  Future<AddComplaintDetailsResponseModel> addComplaintDetails(
    AddComplaintDetailsParams params,
  ) async {
    final formData = FormData.fromMap({
      'extra_text': params.extraText,
      if (params.extraAttachmentPath != null)
        'extra_attachment': await MultipartFile.fromFile(
          params.extraAttachmentPath!,
          filename: params.extraAttachmentPath!.split('/').last,
        ),
    });

    final response = await apiConsumer.post(
      '${EndPoints.addComplaintDetails}/${params.complaintId}',
      isFormData: true,
      data: formData,
    );

    return AddComplaintDetailsResponseModel.fromJson(response);
  }
}
