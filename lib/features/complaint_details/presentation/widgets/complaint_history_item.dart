import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_history_entry_entity.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/card_detais_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/custom_date_info.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/status_color_helper.dart';
import 'package:flutter/material.dart';

class ComplaintHistoryItem extends StatelessWidget {
  final ComplaintHistoryEntryEntity history;

  const ComplaintHistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final statusColor = mapStatusColor(history.status);
    final String dateText = "${history.day}  ${history.date}";

    final bool hasNote =
        history.note != null && history.note!.trim().isNotEmpty;

   
    if (!hasNote) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: CustomDateInfo(
          date: dateText,
          status: history.status,
          statusColor: statusColor,
        ),
      );
    }

   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: CardDetaisWidget(
       
        title: dateText,
       
        status: history.status,
        statuseColor: statusColor,
        fontSize: SizeConfig.diagonal * .022,

        titleDescreption: context.l10n.notes,
        descreption: history.note ?? "",

       
        titleLocation: null,
        location: null,
      ),
    );
  }

}
