import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/repositories/submit_complaint_repository.dart';
import 'package:dartz/dartz.dart';

class GetAgenciesUseCase {
  final SubmitComplaintRepository repository;

  GetAgenciesUseCase(this.repository);

  Future<Either<Failure, List<AgencyEntity>>> call() {
    return repository.getAgencies();
  }
}
