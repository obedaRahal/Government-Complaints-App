import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/delete_complaint_response.dart';
import 'package:dartz/dartz.dart';

abstract class ComplaintDetailsRepository {
  /// إحضار تفاصيل شكوى معيّنة عبر رقمها (ID)
  Future<Either<Failure, ComplaintDetailsEntity>> getComplaintDetails(
    int complaintId,
  );
  Future<Either<Failure, DeleteComplaintResponseEntity>> deleteComplaint(int id);
}
