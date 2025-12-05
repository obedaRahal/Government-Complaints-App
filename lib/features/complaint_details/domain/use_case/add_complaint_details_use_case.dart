import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/complaint_details/domain/repositories/complaint_details_repositry.dart';
import 'package:dartz/dartz.dart';
import '../entities/add_complaint_details_response_entity.dart';
import 'params/add_complaint_details_params.dart';

class AddComplaintDetailsUseCase {
  final ComplaintDetailsRepository repository;

  AddComplaintDetailsUseCase(this.repository);

  Future<Either<Failure, AddComplaintDetailsResponseEntity>> call(
    AddComplaintDetailsParams params,
  ) {
    return repository.addComplaintDetails(params);
  }
}
