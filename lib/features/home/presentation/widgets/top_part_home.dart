
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_feild.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

import '../../../../core/common widget/custom_background_with_child.dart';

class TopPartHome extends StatelessWidget {
  const TopPartHome({
    super.key,
    required this.onChangedSearch,
    required this.onTapProfile,
    required this.onTapNotification,
  });

  final void Function(String) onChangedSearch;
  final void Function() onTapProfile;
  final void Function() onTapNotification;

  @override
  Widget build(BuildContext context) {
String welcomeMessage = CacheHelper.getData(key: "welcomeMessage") ?? "";
    return CustomBackgroundWithChild(
      width: double.infinity,
      backgroundColor: AppColor.primary,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: SizeConfig.height * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              welcomeMessage ,
              //"مرحبا صديقي المواطن عبيده الرحال",
              color: AppColor.white,
              fontSize: SizeConfig.diagonal * .025,
            ),
            SizedBox(height: SizeConfig.height * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.width * .65,
                  height: 30,

                  child: CustomTextField(
                    hint: 'البحث في سجل الشكاوي...',
                    suffixIcon: Icons.search,
                    hintFontSize: SizeConfig.diagonal * .022,
                    borderRadius: 30,
                    onChanged: onChangedSearch,
                  ),
                ),

                CustomButtonWidget(
                  borderRadius: 30,
                  childHorizontalPad: 3,
                  childVerticalPad: 3,
                  backgroundColor: AppColor.white,
                  onTap: onTapProfile,
                  child: Icon(
                    Icons.group_outlined,
                    color: AppColor.middleGrey,
                    size: SizeConfig.height * .04,
                  ),
                ),

                CustomButtonWidget(
                  borderRadius: 30,
                  childHorizontalPad: 3,
                  childVerticalPad: 3,
                  backgroundColor: AppColor.white,
                  onTap: onTapNotification,
                  child: Icon(
                    Icons.notification_important_outlined,
                    color: AppColor.middleGrey,
                    size: SizeConfig.height * .04,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}