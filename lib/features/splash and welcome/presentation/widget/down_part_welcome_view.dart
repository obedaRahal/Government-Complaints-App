import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownPartWelcome extends StatelessWidget {
  const DownPartWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return CustomBackgroundWithChild(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      width: double.infinity,
      backgroundColor: isDark ? AppColor.backGroundGrey : AppColor.primary,
      child: Column(
        children: [
          SizedBox(height: 10),
          Divider(
            color: theme.colorScheme.onSecondary,
            thickness: 3,
            indent: 130,
            endIndent: 130,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextWidget(
              color: theme.colorScheme.onSecondary,
              fontSize: SizeConfig.diagonal * .03,
              "تطبيق يساعد المواطنين على\n انشاء , تنظيم , متابعة الشكاوي\n بكفاءة وسهولة",
            ),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonWidget(
                backgroundColor: isDark
                    ? AppColor.primaryDark
                    : AppColor.lightPurple,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .015,
                borderRadius: 30,
                onTap: () {
                  debugPrint(" registerrrr");
                  context.pushNamed(AppRouteRName.registerView);
                },
                child: CustomTextWidget(
                  "حساب جديد",
                  fontSize: SizeConfig.height * .025,
                  color: AppColor.textColor,
                ),
              ),
              CustomButtonWidget(
                backgroundColor: AppColor.darkGrey,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .015,
                borderRadius: 30,
                onTap: () {
                  context.pushNamed(AppRouteRName.loginView);

                  debugPrint(" loginnnnnnnnn ");
                },
                child: CustomTextWidget(
                  "تسجيل الدخول",
                  fontSize: SizeConfig.height * .025,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
