import 'package:complaints_app/features/complaint_details/domain/entities/complaint_attachment_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_history_entry_entity.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_info_entity.dart';

class ComplaintDetailsEntity {
  final List<ComplaintAttachmentEntity> attachments;
  final ComplaintInfoEntity complaintInfo;
  final List<ComplaintHistoryEntryEntity> history;

  ComplaintDetailsEntity({
    required this.attachments,
    required this.complaintInfo,
    required this.history,
  });
}
