class AddComplaintDetailsParams {
  final int complaintId;
  final String extraText;
  final String? extraAttachmentPath;
  final List<String> attachmentPaths;

  AddComplaintDetailsParams({
    required this.complaintId,
    required this.extraText,
    this.extraAttachmentPath,
    required this.attachmentPaths,
  });
}
