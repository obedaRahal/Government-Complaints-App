import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/complaint_details/data/models/complaint_details_model.dart';
import 'package:complaints_app/features/complaint_details/data/models/delete_complaint_response_model.dart';
import 'package:flutter/foundation.dart';

abstract class ComplaintDetailsRemoteDataSource {
  Future<ComplaintDetailsModel> getComplaintDetails(int complaintId);
  Future<DeleteComplaintResponseModel> deleteComplaint(int id);
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

    // عدّلي هذا السطر حسب الـ endpoint الحقيقي عندك
    // مثلاً: 'citizen/complaints/$complaintId' أو 'complaints/$complaintId'
    final response = await apiConsumer.get(
      "${EndPoints.complaintDetails}$complaintId",
    );

    return ComplaintDetailsModel.fromJson(response as Map<String, dynamic>);
  }
   @override
  Future<DeleteComplaintResponseModel> deleteComplaint(int id) async {
    final response =
        await apiConsumer.delete('${EndPoints.deleteComplaint}/$id');
    return DeleteComplaintResponseModel.fromJson(response);
  }
  
}
