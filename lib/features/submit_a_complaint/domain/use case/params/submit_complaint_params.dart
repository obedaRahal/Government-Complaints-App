class SubmitComplaintParams {
  final int agencyId;          
  final int complaintTypeId;   
  final String title;          
  final String description;    
  final String locationText;   
  final List<String> attachmentPaths;

  const SubmitComplaintParams({
    required this.agencyId,
    required this.complaintTypeId,
    required this.title,
    required this.description,
    required this.locationText,
    this.attachmentPaths = const [],
  });
}
