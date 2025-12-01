import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/repositories/complaint_details_repositry.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/params/get_complaint_details_params.dart';
import 'package:dartz/dartz.dart';

class GetComplaintDetailsUseCase {
  final ComplaintDetailsRepository repository;

  GetComplaintDetailsUseCase(this.repository);

  Future<Either<Failure, ComplaintDetailsEntity>> call(
    GetComplaintDetailsParams params,
  ) {
    return repository.getComplaintDetails(params.complaintId);
  }
}
