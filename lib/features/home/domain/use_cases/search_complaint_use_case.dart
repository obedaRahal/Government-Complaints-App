import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/complaint_entity.dart';
import 'package:complaints_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class SearchComplaintUseCase {
  final HomeRepository repository ;

  SearchComplaintUseCase({required this.repository});

  Future<Either<Failure , ComplaintEntity?>> call(String search){
    return repository.searchComplaint(search: search);
  }
}