import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class CardDetaisWidget extends StatelessWidget {
  const CardDetaisWidget({
    super.key,
    required this.title,
    required this.status,
    required this.titleDescreption,
    this.titleLocation,
    required this.descreption,
    this.location,
    required this.statuseColor,
    required this.fontSize,
  });
  final String title;
  final String status;
  final String titleDescreption;
  final String? titleLocation;
  final String descreption;
  final double fontSize;
  final String? location;
  final Color statuseColor;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColor.borderContainerDark
              : AppColor.borderContainer,
          width: 1,
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    title,
                    fontSize: fontSize,
                    color:theme.colorScheme.secondary,
                  ),
                  CustomBackgroundWithChild(
                    borderRadius: BorderRadius.circular(6),
                    backgroundColor: statuseColor,
                    childHorizontalPad: 6,
                    childVerticalPad: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomTextWidget(
                        status,
                        fontSize: SizeConfig.diagonal * .02,
                        color:theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(endIndent: 10, indent: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          titleDescreption,
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.greyTextInCard,
                        ),
                        const SizedBox(height: 6),
                        CustomTextWidget(
                          descreption,
                          fontSize: SizeConfig.diagonal * .016,
                          color: isDark? AppColor.whiteDark: AppColor.textInCard,
                          maxLines: 7,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),
                  Expanded(
                    flex: titleLocation == null ? 0 : 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          titleLocation ?? "",
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.greyTextInCard,
                        ),
                        const SizedBox(height: 6),
                        CustomTextWidget(
                          location ?? "",
                          fontSize: SizeConfig.diagonal * .016,
                          color: isDark? AppColor.whiteDark: AppColor.textInCard,
                          maxLines: 5,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
