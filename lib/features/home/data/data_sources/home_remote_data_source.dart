import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/home/data/models/search_complaint_model.dart';
import 'package:flutter/material.dart';

import '../models/complaints_page_model.dart';

abstract class HomeRemoteDataSource {
  Future<ComplaintsPageModel> getComplaints({
    required int page,
    required int perPage,
  });


    Future<SearchComplaintModel?> searchComplaint({
    required String search,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<ComplaintsPageModel> getComplaints({
    required int page,
    required int perPage,
  }) async {
    debugPrint(
      "============ HomeRemoteDataSourceImpl.getComplaints ============",
    );

    final response = await apiConsumer.post(
      EndPoints.showComplaints,
      data: {'page': page, 'per_page': perPage},
    );

    debugPrint("← response (getComplaints): $response");
    debugPrint("=================================================");


    return ComplaintsPageModel.fromJson(response.data);
  }
  
  @override
  Future<SearchComplaintModel?> searchComplaint({required String search}) {
    // TODO: implement searchComplaint
    throw UnimplementedError();
  }
}
