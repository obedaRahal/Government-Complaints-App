class ComplaintHistoryEntryEntity {
  final String day;    // مثال: "الخميس"
  final String date;   // مثال: "2025-11-27" (ممكن لاحقاً نعمله DateTime)
  final String status; // مثال: "معلقة"
  final String? note;  // ممكن تكون null

  ComplaintHistoryEntryEntity({
    required this.day,
    required this.date,
    required this.status,
    this.note,
  });
}
