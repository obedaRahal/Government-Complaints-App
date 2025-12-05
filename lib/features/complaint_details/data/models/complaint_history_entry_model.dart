import 'package:complaints_app/features/complaint_details/domain/entities/complaint_history_entry_entity.dart';

class ComplaintHistoryEntryModel {
  final String day;
  final String date;
  final String status;
  final String? note;

  ComplaintHistoryEntryModel({
    required this.day,
    required this.date,
    required this.status,
    this.note,
  });

  factory ComplaintHistoryEntryModel.fromJson(Map<String, dynamic> json) {
    return ComplaintHistoryEntryModel(
      day: json['day'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      note: json['note'] as String?,
    );
  }

  ComplaintHistoryEntryEntity toEntity() {
    return ComplaintHistoryEntryEntity(
      day: day,
      date: date,
      status: status,
      note: note,
    );
  }
}
