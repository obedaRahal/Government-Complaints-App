import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/submit_complaint_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/repositories/submit_complaint_repository.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/params/submit_complaint_params.dart';
import 'package:dartz/dartz.dart';

class SubmitComplaintUseCase {
  final SubmitComplaintRepository repository;

  SubmitComplaintUseCase(this.repository);

  Future<Either<Failure, SubmitComplaintEntity>> call(
    SubmitComplaintParams params,
  ) {
    return repository.submitComplaint(params);
  }
}
