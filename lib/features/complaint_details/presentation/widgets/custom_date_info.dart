import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class CustomDateInfo extends StatelessWidget {
  const CustomDateInfo({
    super.key,
    required this.date,
    required this.status,
    required this.statusColor,
  });
  final String date;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.borderContainer, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x17000000),
            blurRadius: 6,
            spreadRadius: 0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              date,
              fontSize: SizeConfig.diagonal * .016,
              color: AppColor.textInCard,
              maxLines: 5,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,
            ),
            CustomBackgroundWithChild(
              borderRadius: BorderRadius.circular(8),
              backgroundColor: statusColor,
              childHorizontalPad: 6,
              childVerticalPad: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomTextWidget(
                  status,
                  fontSize: SizeConfig.diagonal * .02,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
