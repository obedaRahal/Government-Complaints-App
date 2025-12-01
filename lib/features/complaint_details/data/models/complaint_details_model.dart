import 'package:complaints_app/features/complaint_details/data/models/complaint_attachment_model.dart';
import 'package:complaints_app/features/complaint_details/data/models/complaint_history_entry_model.dart';
import 'package:complaints_app/features/complaint_details/data/models/complaint_info_model.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_details_entity.dart';

class ComplaintDetailsModel {
  final List<ComplaintAttachmentModel> attachments;
  final ComplaintInfoModel complaintInfo;
  final List<ComplaintHistoryEntryModel> history;

  ComplaintDetailsModel({
    required this.attachments,
    required this.complaintInfo,
    required this.history,
  });

  factory ComplaintDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final attachmentsJson = data['attachments'] as List<dynamic>? ?? [];
    final historyJson = data['history'] as List<dynamic>? ?? [];

    return ComplaintDetailsModel(
      attachments: attachmentsJson
          .map((e) => ComplaintAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      complaintInfo: ComplaintInfoModel.fromJson(
        data['complaint_info'] as Map<String, dynamic>,
      ),
      history: historyJson
          .map((e) => ComplaintHistoryEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ComplaintDetailsEntity toEntity() {
    return ComplaintDetailsEntity(
      attachments: attachments.map((e) => e.toEntity()).toList(),
      complaintInfo: complaintInfo.toEntity(),
      history: history.map((e) => e.toEntity()).toList(),
    );
  }
}
