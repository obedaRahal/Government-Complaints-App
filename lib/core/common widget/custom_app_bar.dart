import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          //textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, bottom: 14),
              child: CustomTextWidget(
                title,
                fontSize: SizeConfig.diagonal * (isEn ? .03 : .04),
                color: theme.colorScheme.secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, bottom: 12),
              child: IconButton(
                icon: Icon(
                  //   isRtl ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
                  Icons.arrow_forward_ios,
                  size: 28,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
