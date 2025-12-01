import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/common widget/custom_text_widget.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/domain/entities/complaint_history_entry_entity.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/card_detais_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/custom_date_info.dart';
import 'package:flutter/material.dart';

class ComplaintHistoryItem extends StatelessWidget {
  final ComplaintHistoryEntryEntity history;

  const ComplaintHistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final statusColor = _mapStatusColor(history.status);
    final String dateText = "${history.day}  ${history.date}";

    final bool hasNote =
        history.note != null && history.note!.trim().isNotEmpty;

    // 🔹 لو ما في ملاحظات → الكرت الصغير فقط (مثل حالة "معلقة" بالصورة)
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

    // 🔸 لو في ملاحظات → كرت كبير يحتوي الحالة + "ملاحظات" + النص
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: CardDetaisWidget(
        // السطر العلوي (يمين): التاريخ
        title: dateText,
        // البادج (يسار): الحالة
        status: history.status,
        statuseColor: statusColor,
        fontSize: SizeConfig.diagonal * .022,

        // النص داخل الكرت
        titleDescreption: "ملاحظات",
        descreption: history.note ?? "",

        // ما بدنا نحط عمود تاني (العنوان/المكان) بهالكرت
        titleLocation: null,
        location: null,
      ),
    );
  }

  Color _mapStatusColor(String status) {
    switch (status) {
      case "معلقة":
        return AppColor.middleGrey; // رمادي
      case "قيد المعالجة":
        return AppColor.primary; // أزرق/بنفسجي حسب تصميمك
      case "تمت معالجتها":
        return Colors.green;
      case "تم رفضها":
        return Colors.red;
      case "بحاجة لمعلومات إضافية":
        return Colors.blueGrey;
      default:
        return AppColor.borderContainer;
    }
  }
}
