import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/repositories/submit_complaint_repository.dart';
import 'package:dartz/dartz.dart';

class GetComplaintTypeUseCase {
  final SubmitComplaintRepository repository;

  GetComplaintTypeUseCase(this.repository);
  Future<Either<Failure, List<ComplaintTypeEntity>>> call(){
    return repository.getComplaintType();
  }
}
