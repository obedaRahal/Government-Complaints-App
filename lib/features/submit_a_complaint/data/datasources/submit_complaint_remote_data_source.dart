import 'dart:io';

import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/submit_a_complaint/data/models/complain_type_model.dart';
import 'package:complaints_app/features/submit_a_complaint/data/models/get_agency_model.dart';
import 'package:complaints_app/features/submit_a_complaint/data/models/submit_complaint_model.dart';
import 'package:dio/dio.dart';

abstract class SubmitComplaintRemoteDataSource {
  Future<List<AgencyModel>> getAgencies();
  Future<List<ComplaintTypeModel>> getComplaintType();
  Future<SubmitComplaintModel> submitComplaint({
    required int agencyId,
    required int complaintTypeId,
    required String title,
    required String description,
    required String locationText,
    required List<String> attachmentPaths,
  });
}

class SubmitComplaintDataSourceImpl implements SubmitComplaintRemoteDataSource {
  final ApiConsumer api;

  SubmitComplaintDataSourceImpl(this.api);
  
  // ****** Get Agencies ******
  @override
  Future<List<AgencyModel>> getAgencies() async {
    final response = await api.get(EndPoints.agency);

    final List rawList = response['data'] as List;

    return rawList
        .map((item) => AgencyModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
  // ****** Get Complaint Type ******
  @override
  Future<List<ComplaintTypeModel>> getComplaintType() async {
    final response = await api.get(EndPoints.complaintType);
    final List rawList = response['data'] as List;

    return rawList
        .map((item) => ComplaintTypeModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
  // ****** Submit Complaint ******
   @override
  Future<SubmitComplaintModel> submitComplaint({
    required int agencyId,
    required int complaintTypeId,
    required String title,
    required String description,
    required String locationText,
    required List<String> attachmentPaths,
  }) async {
    // نجهّز الـ body
    final Map<String, dynamic> data = {
      'agency_id': agencyId,
      'complaint_type_id': complaintTypeId,
      'title': title,
      'description': description,
      'location_text': locationText,
    };

    // تجهيز الصور كمرفقات لو فيه
    if (attachmentPaths.isNotEmpty) {
      final files = <MultipartFile>[];

      for (final path in attachmentPaths) {
        files.add(
          await MultipartFile.fromFile(
            path,
            filename: path.split(Platform.pathSeparator).last,
          ),
        );
      }

      // backend يستخدم attachments[]
      data['attachments[]'] = files;
    }

    final response = await api.post(
      EndPoints.createComplaint, // نضيفه بعد شوي في EndPoints
      data: data,
      isFormData: true, // مهم عشان يتحوّل لـ multipart/form-data
    );

    return SubmitComplaintModel.fromJson(
      response as Map<String, dynamic>,
    );
  }
}
