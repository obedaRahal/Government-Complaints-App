import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(height: 50, width: 1.6, color: isDark? AppColor.backGroundGrey: AppColor.lightGray);
  }
}
