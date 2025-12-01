class ComplaintInfoEntity {
  final String complaintType;
  final String agency;
  final int complaintNumber;
  final String title;
  final String description;
  final String status;
  final String locationText;
  final String createdAt;

  ComplaintInfoEntity({
    required this.complaintType,
    required this.agency,
    required this.complaintNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.locationText,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        complaintType,
        agency,
        complaintNumber,
        title,
        description,
        status,
        locationText,
        createdAt, // 👈
      ];
}
