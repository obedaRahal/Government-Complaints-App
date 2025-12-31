import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/localization/localization_ext.dart';
import 'home_tour_keys.dart';

class HomeTourTargets {
  static List<TargetFocus> build(
    BuildContext context, {
    required VoidCallback onNext,
    required VoidCallback onFinish,
  }) {
    Widget coachCard(String title, String desc, {bool isLast = false}) {
      final theme = Theme.of(context);
      final isDark = Theme.of(context).brightness == Brightness.dark;

      return Container(
        width: 300,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary, // ✅ خلفية البطاقة حسب الثيم
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(isDark ? 0.35 : 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.25 : 0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              title,
              color: theme.colorScheme.primary,
              fontSize: SizeConfig.diagonal * .024,
            ),
            const SizedBox(height: 8),
            CustomTextWidget(
              desc,
              color: theme.colorScheme.secondary,
              fontSize: SizeConfig.diagonal * .020,
            ),
            const SizedBox(height: 12),

            // ✅ زر التنقل
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.surface, // ✅ حسب الثيم
                  foregroundColor: theme.colorScheme.primary, // ✅ لون النص
                  elevation: 0, // ✅ بدون ظل
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: theme.colorScheme.primary, // ✅ لون البوردر
                      width: 1.2,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                ),
                onPressed: isLast ? onFinish : onNext,
                child: CustomTextWidget(
                  isLast ? context.l10n.common_ok : 'التالي',
                  color: theme.colorScheme.primary,
                  fontSize: SizeConfig.diagonal * .020,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return [
      TargetFocus(
        identify: "add_complaint",
        keyTarget: HomeTourKeys.addComplaintKey,
        enableTargetTab: false,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: coachCard(
              context.l10n.tour_add_complaint_title,
              context.l10n.tour_add_complaint_desc,
            ),
          ),
        ],
      ),

      TargetFocus(
        identify: "notifications",
        keyTarget: HomeTourKeys.notificationsKey,
        enableTargetTab: false,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: coachCard(
              context.l10n.tour_notifications_title,
              context.l10n.tour_notifications_desc,
            ),
          ),
        ],
      ),

      TargetFocus(
        identify: "settings",
        keyTarget: HomeTourKeys.settingsKey,
        enableTargetTab: false,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: coachCard(
              context.l10n.tour_settings_title,
              context.l10n.tour_settings_desc,
              isLast: true,
            ),
          ),
        ],
      ),
    ];
  }
}
