import 'package:complaints_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/complaints_page_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, ComplaintsPageEntity>> getComplaints({
    required int page,
    required int perPage,
  });
}
