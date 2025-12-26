import 'package:flutter/material.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';

Color mapStatusColor(String status) {
  switch (status) {
    case "معلقة":
      return AppColor.middleGrey;
    case "قيد المعالجة":
      return AppColor.primary;
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
Color mapStatusColorDark(String status) {
  switch (status) {
    case 'معلقة':
      return AppColor.greyDark;
    case 'قيد المعالجة':
      return AppColor.blueDark;
    case 'تم معالجتها':
      return AppColor.greenDark;
    case 'تم رفضها':
      return AppColor.redDark;
    default:
      return AppColor.middleGrey;
  }
}

