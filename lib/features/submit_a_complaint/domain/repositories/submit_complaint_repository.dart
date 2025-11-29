import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/submit_complaint_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/params/submit_complaint_params.dart';
import 'package:dartz/dartz.dart';

abstract class SubmitComplaintRepository {
  Future<Either<Failure, List<AgencyEntity>>> getAgencies();
  Future<Either<Failure, List<ComplaintTypeEntity>>> getComplaintType();
   Future<Either<Failure, SubmitComplaintEntity>> submitComplaint(
    SubmitComplaintParams params,
  );

}
