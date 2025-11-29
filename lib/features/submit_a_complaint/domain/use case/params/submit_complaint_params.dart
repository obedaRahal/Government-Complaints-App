class SubmitComplaintParams {
  final int agencyId;          // agency_id
  final int complaintTypeId;   // complaint_type_id
  final String title;          // title
  final String description;    // description
  final String locationText;   // location_text
  final List<String> attachmentPaths; // attachments[]

  const SubmitComplaintParams({
    required this.agencyId,
    required this.complaintTypeId,
    required this.title,
    required this.description,
    required this.locationText,
    this.attachmentPaths = const [],
  });
}
