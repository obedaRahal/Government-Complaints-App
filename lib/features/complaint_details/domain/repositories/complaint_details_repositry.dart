import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/add_complaint_details_response_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/delete_complaint_response.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/params/add_complaint_details_params.dart';
import 'package:dartz/dartz.dart';

abstract class ComplaintDetailsRepository {
 
  Future<Either<Failure, ComplaintDetailsEntity>> getComplaintDetails(
    int complaintId,
  );
  Future<Either<Failure, DeleteComplaintResponseEntity>> deleteComplaint(int id);
  Future<Either<Failure, AddComplaintDetailsResponseEntity>>
      addComplaintDetails(AddComplaintDetailsParams params);
}
