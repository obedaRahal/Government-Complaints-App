import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Align(
      alignment: isRtl ? Alignment.centerLeft : Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: theme.colorScheme.secondary.withOpacity(
              0.12,
            ), // رمادي/لون خفيف
            highlightColor: theme.colorScheme.secondary.withOpacity(0.06),
            onTap: () {
              // GoRouter.of(context).pop();
              Future.microtask(() => GoRouter.of(context).pop());
            },
            child: Row(
              // mainAxisAlignment: isRtl
              //     ? MainAxisAlignment.end
              //     : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isRtl) ...[
                  CustomTextWidget(
                    context.l10n.arrow_back,
                    color: theme.colorScheme.secondary,
                    fontSize: 22,
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: theme.colorScheme.secondary,
                    size: 18,
                  ),
                ] else ...[
                  Icon(
                    Icons.arrow_back_ios,
                    color: theme.colorScheme.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  CustomTextWidget(
                    context.l10n.arrow_back,
                    color: theme.colorScheme.secondary,
                    fontSize: 22,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
