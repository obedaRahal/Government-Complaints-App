class AddComplaintDetailsParams {
  final int complaintId;
  final String extraText;
  final List<String> attachmentPaths;

  AddComplaintDetailsParams({
    required this.complaintId,
    required this.extraText,
    required this.attachmentPaths,
  });
}
