import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/core/network/network_info.dart';
import 'package:complaints_app/features/submit_a_complaint/data/datasources/submit_complaint_remote_data_source.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/complaint_type_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/get_agency_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/entities/submit_complaint_entity.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/repositories/submit_complaint_repository.dart';
import 'package:complaints_app/features/submit_a_complaint/domain/use%20case/params/submit_complaint_params.dart';
import 'package:dartz/dartz.dart';

class SubmitComplaintRepositoryImpl implements SubmitComplaintRepository {
  final SubmitComplaintRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

  SubmitComplaintRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  // ****** Get Agencies ******
 @override
  Future<Either<Failure, List<AgencyEntity>>> getAgencies() async {
    if (!await networkInfo.isConnected) {
      return Left(
        ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
      );
    }

    try {
      final models = await remoteDataSource.getAgencies();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errMessage: e.errorModel.errorMessage),
      );
    } catch (_) {
      return Left(
        ServerFailure(errMessage: 'حدث خطأ غير متوقع'),
      );
    }
  }
  // ****** Get Complaint Type ******
  @override
  Future<Either<Failure, List<ComplaintTypeEntity>>> getComplaintType()async {
  if (!await networkInfo.isConnected) {
      return Left(
        ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
      );
    }
    try{
      final models = await remoteDataSource.getComplaintType();
     final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errMessage: e.errorModel.errorMessage),
      );
    } catch (_) {
      return Left(
        ServerFailure(errMessage: 'حدث خطأ غير متوقع'),
      );
    }
  }
  // ****** Submit Complaint ******
  @override
  Future<Either<Failure, SubmitComplaintEntity>> submitComplaint(
    SubmitComplaintParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
        ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
      );
    }

    try {
      final model = await remoteDataSource.submitComplaint(
        agencyId: params.agencyId,
        complaintTypeId: params.complaintTypeId,
        title: params.title,
        description: params.description,
        locationText: params.locationText,
        attachmentPaths: params.attachmentPaths,
      );

      final entity = model.toEntity();
      return Right(entity);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errMessage: e.errorModel.errorMessage),
      );
    } catch (_) {
      return Left(
        ServerFailure(errMessage: 'حدث خطأ غير متوقع'),
      );
    }
  }
}
