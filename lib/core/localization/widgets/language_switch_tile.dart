import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../locale_cubit.dart';

class LanguageSwitchTile extends StatelessWidget {
  const LanguageSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final lang = locale.languageCode; // 'ar' or 'en'
        final isRtl = Directionality.of(context) == TextDirection.rtl;

        final title = (lang == 'ar') ? 'اللغة' : 'Language';

        Widget radioItem({required String value, required String label}) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (value == 'ar') {
                context.read<LocaleCubit>().setArabic();
              } else {
                context.read<LocaleCubit>().setEnglish();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: value,
                  groupValue: lang,
                  onChanged: (v) {
                    if (v == 'ar') {
                      context.read<LocaleCubit>().setArabic();
                    } else {
                      context.read<LocaleCubit>().setEnglish();
                    }
                  },
                ),
                CustomTextWidget(
                  label,
                  color: theme.colorScheme.secondary,
                  fontSize: 16,
                ),
              ],
            ),
          );
        }

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // crossAxisAlignment:
              //     isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: isRtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: CustomTextWidget(
                    title,
                    color: theme.colorScheme.secondary,
                    fontSize: 22,
                    textAlign: isRtl ? TextAlign.right : TextAlign.left,
                  ),
                ),
                const SizedBox(height: 6),

                Align(
                  alignment: isRtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      radioItem(value: 'ar', label: 'العربية'),
                      radioItem(value: 'en', label: 'English'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
