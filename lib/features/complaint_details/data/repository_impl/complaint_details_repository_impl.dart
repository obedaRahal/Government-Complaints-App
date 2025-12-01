import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/core/network/network_info.dart';
import 'package:complaints_app/features/complaint_details/data/data_sources/complaint_details_remote_data_source.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/repositories/complaint_details_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class ComplaintDetailsRepositoryImpl implements ComplaintDetailsRepository {
  final ComplaintDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ComplaintDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ComplaintDetailsEntity>> getComplaintDetails(
    int complaintId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(
       ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
      );
    }

    try {
      debugPrint(
        "ComplaintDetailsRepositoryImpl.getComplaintDetails -> id: $complaintId",
      );

      final model = await remoteDataSource.getComplaintDetails(complaintId);
      final entity = model.toEntity();

      return Right(entity);
    } on ServerException catch (e) {
      debugPrint(
        "ComplaintDetailsRepositoryImpl ServerException: ${e.errorModel.errorMessage}",
      );
      return Left(
       ServerFailure(errMessage: e.errorModel.errorMessage),
      );
    } catch (e) {
      debugPrint("ComplaintDetailsRepositoryImpl Unknown error: $e");
      return Left(
         ServerFailure(errMessage: 'حدث خطأ غير متوقع'),
      );
    }
  }
}
