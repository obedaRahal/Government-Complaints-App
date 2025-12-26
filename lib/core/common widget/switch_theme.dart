import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_cubit.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.mode == ThemeMode.dark;

        return ListTile(
          contentPadding: EdgeInsets.zero, // ✅ يشيل المسافة الخارجية
          horizontalTitleGap: 0, // ✅ يقلل فجوة العنوان
          minLeadingWidth: 0, // ✅ ما يحجز مساحة لليدينغ
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight, // ✅ يلزق يمين
                    child: CustomTextWidget(
                      isDark ? 'الوضع الليلي' : 'الوضع النهاري',
                      color: isDark ? AppColor.whiteDark : AppColor.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().change(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ],
            ),
          ),
          onTap: () => context.read<ThemeCubit>().toggleLightDark(),
        );
      },
    );
  }
}
