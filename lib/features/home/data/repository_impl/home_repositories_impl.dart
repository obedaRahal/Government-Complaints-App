// import 'package:complaints_app/core/errors/expentions.dart';
// import 'package:complaints_app/core/errors/failure.dart';
// import 'package:complaints_app/features/home/data/models/home_remote_data_source.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';

// import '../../domain/entities/complaints_page_entity.dart';
// import '../../domain/repositories/home_repository.dart';

// class HomeRepositoryImpl implements HomeRepository {
//   final HomeRemoteDataSource remoteDataSource;

//   HomeRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<Either<Failure, ComplaintsPageEntity>> getComplaints({
//     required int page,
//     required int perPage,
//   }) async {
//     debugPrint("============ AuthRepositoryImpl.getComplaints ============");
//     debugPrint("→ params: {page: $page, perPage: $perPage }");
//     try {
//       debugPrint("→ calling remoteDataSource.getComplaints");

//       final result = await remoteDataSource.getComplaints(
//         page: page,
//         perPage: perPage,
//       );
//       debugPrint("← remoteDataSource.getComplaints success, mapped to entity");
//       debugPrint("=================================================");

//       return Right(result);
//     } on ServerException catch (e) {
//       debugPrint(
//         "✗ HomeRepositoryImpl.getComplaints ServerException: ${e.errorModel.errorMessage}",
//       );
//       debugPrint("=================================================");
//       return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
//     } on CacheException catch (e) {
//       debugPrint(
//         "✗ HomeRepositoryImpl.getComplaints CacheException: ${e.errorMessage}",
//       );
//       debugPrint("=================================================");
//       return Left(CacheFailure(errMessage: e.errorMessage));
//     } catch (e) {
//       debugPrint("✗ HomeRepositoryImpl.getComplaints Unexpected error: $e");
//       debugPrint("=================================================");
//       return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
//     }
//   }
// }
