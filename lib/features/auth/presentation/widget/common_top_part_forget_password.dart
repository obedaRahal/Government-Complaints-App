import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonTopPartForgetPassword extends StatelessWidget {
  const CommonTopPartForgetPassword({
    super.key,
    required this.title,
    required this.bodyText,
    required this.img,
    required this.imgHeight,
  });

  final String title;
  final String bodyText;
  final String img;
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    return CustomBackgroundWithChild(
      borderRadius: BorderRadius.circular(20),
      width: double.infinity,
      backgroundColor: theme.colorScheme.onPrimary,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: ArrowBack()),
          SvgPicture.asset(img, height: imgHeight),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextWidget(
              title,
              fontSize: SizeConfig.diagonal * (isEn ? .03 : .05),
              textAlign: TextAlign.center,
              // maxLines: 1,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: CustomTextWidget(
              bodyText,
              color: theme.colorScheme.secondary,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: SizeConfig.height * .03),
        ],
      ),
    );
  }
}
