class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String date;
  final int? complaintId;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.complaintId
  });
}
