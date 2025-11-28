import '../../domain/entities/pagination_meta_entity.dart';

class PaginationMetaModel extends PaginationMetaEntity {
  const PaginationMetaModel({
    required super.currentPage,
    required super.perPage,
    required super.total,
    required super.lastPage,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
      lastPage: json['last_page'] as int,
    );
  }
}
