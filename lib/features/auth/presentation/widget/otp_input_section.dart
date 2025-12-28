import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/tow_text_row.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputSection extends StatelessWidget {
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onSubmit;
  final VoidCallback onResend;
  final bool isSubmitting;
  final int remainingSeconds;
  final String? buttonText;

  const OtpInputSection({
    super.key,
    required this.onOtpChanged,
    required this.onSubmit,
    required this.onResend,
    required this.isSubmitting,
    required this.remainingSeconds,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(1, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(context.l10n.input_otp_code, color:theme.colorScheme.secondary),
            CustomTextWidget("$minutes:$seconds"),
          ],
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            errorTextDirection: Directionality.of(context),
            appContext: context,
            length: 6,
            textStyle: TextStyle(
              fontSize: SizeConfig.height * .025,
              color:theme.colorScheme.secondary,
              fontFamily: AppFonts.reemKufi,
            ),
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: SizeConfig.height * .07,
              fieldWidth: SizeConfig.height * .07,
              activeFillColor: theme.inputDecorationTheme.fillColor,
              selectedFillColor: theme.inputDecorationTheme.fillColor,
              inactiveFillColor: theme.inputDecorationTheme.fillColor,
              inactiveColor: theme.colorScheme.onPrimary,
              selectedColor: theme.colorScheme.primary,
              activeColor: theme.colorScheme.primary,
              errorBorderColor: AppColor.red,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onChanged: onOtpChanged,
            validator: (value) {
              if (value == null || value.length != 6) {
                return context.l10n.otp_invalid_6_digits;
              }
              return null;
            },
          ),
        ),

        SizedBox(height: SizeConfig.height * .06),

        isSubmitting
            ? const Center(child: CircularProgressIndicator())
            : CustomButtonWidget(
                width: double.infinity,
                backgroundColor:theme.colorScheme.primary,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .012,
                borderRadius: 10,
                onTap: onSubmit,
                child: CustomTextWidget(
                  buttonText ?? context.l10n.confirm_entry,
                  fontSize: SizeConfig.height * .025,
                  color:theme.scaffoldBackgroundColor,
                ),
              ),

        SizedBox(height: SizeConfig.height * .02),

        TowTextRow(
         text: context.l10n.didnt_get_code,      // ✅
actionText: context.l10n.resent_otp_code,
          onTap: onResend,
        ),
      ],
    );
  }
}
