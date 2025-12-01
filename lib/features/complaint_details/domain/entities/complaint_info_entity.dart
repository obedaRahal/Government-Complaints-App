class ComplaintInfoEntity {
  final String complaintType;
  final String agency;
  final int complaintNumber;
  final String title;
  final String description;
  final String status;
  final String locationText;

  ComplaintInfoEntity({
    required this.complaintType,
    required this.agency,
    required this.complaintNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.locationText,
  });
}
