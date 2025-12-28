import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/widget/down_part_welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WelcomeViewBody()));
  }
}

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = Localizations.localeOf(context).languageCode == 'en';
    final brandFontSize = SizeConfig.diagonal * (isEn ? 0.043 : 0.05);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: SvgPicture.asset(
                isDark ? AppImage.splashLogoDark : AppImage.splashLogo,
                height: SizeConfig.height * .065,
              ),
            ),
            Expanded(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: context.l10n.brand_part1,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontFamily: AppFonts.tasees,
                            fontSize: brandFontSize,
                          ),
                        ),
                        TextSpan(
                          text: context.l10n.brand_part2,
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontFamily: AppFonts.tasees,
                            fontSize: brandFontSize,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),

        Stack(
          children: [
            SizedBox(
              width: SizeConfig.width * 1,
              child: SvgPicture.asset(
                //height: 120,
                width: SizeConfig.width * 1.6,
                isDark ? AppImage.zigzagLineDark : AppImage.zigzagLine,
                fit: BoxFit.cover,
              ),
            ),

            PositionedDirectional(
              start: SizeConfig.width * 0.26, 
              end: SizeConfig.width * 0.26,
              top: SizeConfig.height * .1,
              child: CustomBackgroundWithChild(
                height: SizeConfig.height * .09,
                //width: 100,
                backgroundColor: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(15),
                childHorizontalPad: 10,
                childVerticalPad: 2,
                child: CustomTextWidget(
                  context.l10n.welcome,
                  fontSize: SizeConfig.diagonal * .037,
                ),
              ),
            ),
          ],
        ),

        DownPartWelcome(),
      ],
    );
  }
}
