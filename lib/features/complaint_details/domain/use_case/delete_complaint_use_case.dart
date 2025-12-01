import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/delete_complaint_response.dart';
import 'package:complaints_app/features/complaint_details/domain/repositories/complaint_details_repositry.dart';
import 'package:dartz/dartz.dart';

class DeleteComplaintUseCase {
  final ComplaintDetailsRepository repository;

  DeleteComplaintUseCase(this.repository);

  Future<Either<Failure, DeleteComplaintResponseEntity>> call(int complaintId) {
    return repository.deleteComplaint(complaintId);
  }
}
