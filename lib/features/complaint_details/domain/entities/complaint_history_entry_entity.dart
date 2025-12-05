class ComplaintHistoryEntryEntity {
  final String day;   
  final String date;  
  final String status;
  final String? note; 

  ComplaintHistoryEntryEntity({
    required this.day,
    required this.date,
    required this.status,
    this.note,
  });
}
