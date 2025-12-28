import 'package:complaints_app/core/common widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/home/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showNotificationsBottomSheet({
  required BuildContext parentContext,
  String? title,
}) {
  final homeCubit = parentContext.read<HomeCubit>();

  homeCubit.loadNotifications();

  showModalBottomSheet(
    context: parentContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.2),
    elevation: 0,
    builder: (ctx) {
      final height = SizeConfig.height * 0.6;
      final isDark = Theme.of(ctx).brightness == Brightness.dark;
      final theme = Theme.of(ctx);
      return BlocProvider.value(
        value: homeCubit,
        child: SafeArea(
          top: false,
          child: Container(
            height: height,
            // padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: SizeConfig.width * .17,
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                SizedBox(height: SizeConfig.height * .01),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomTextWidget(
                    // title ?? parentContext.l10n.notification_bottom_sheet,
                    title ?? ctx.l10n.notification_bottom_sheet,
                    fontSize: SizeConfig.diagonal * .028,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 12),
                Divider(
                  thickness: 2,
                  color: isDark ? AppColor.backGroundGrey : AppColor.lightGray,
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.isNotificationsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.notificationsErrorMessage != null) {
                        return Center(
                          child: CustomTextWidget(
                            state.notificationsErrorMessage!,
                            color: AppColor.red,
                          ),
                        );
                      }

                      final list = state.notifications;
                      if (list.isEmpty) {
                        return Center(
                          child: CustomTextWidget(
                            context.l10n.not_found_notification,
                            color: AppColor.middleGrey,
                            fontSize: SizeConfig.diagonal * .026,
                          ),
                        );
                      }

                      return _buildNotificationsBody(context, list);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildNotificationsBody(
  BuildContext context,
  List<NotificationEntity> list,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final theme = Theme.of(context);
  final isRtl = Directionality.of(context) == TextDirection.rtl;

  return ListView.separated(
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemCount: list.length,
    separatorBuilder: (_, __) => Padding(
      // padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * .15),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: SizeConfig.width * .15,
      ),
      child: Divider(
        color: isDark ? AppColor.backGroundGrey : AppColor.dividerLight,
        thickness: 1,
      ),
    ),
    itemBuilder: (context, index) {
      final n = list[index];
      final iconWidget = CustomBackgroundWithChild(
        borderRadius: BorderRadius.circular(30),
        height: SizeConfig.width * .12,
        width: SizeConfig.width * .12,
        backgroundColor: const Color(0xFFF5F8FF),
        child: Icon(
          Icons.notifications_none,
          color: theme.colorScheme.primary,
          size: SizeConfig.width * .07,
        ),
      );

      final contentWidget = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              n.title,
              fontSize: SizeConfig.diagonal * .025,
              color: theme.colorScheme.secondary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: SizeConfig.height * .003),
            CustomTextWidget(
              n.body,
              fontSize: SizeConfig.diagonal * .021,
              color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start, // ✅
            ),
            SizedBox(height: SizeConfig.height * .004),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: SizeConfig.diagonal * .018,
                  color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
                ),
                SizedBox(width: SizeConfig.width * .01),
                CustomTextWidget(
                  n.date,
                  fontSize: SizeConfig.diagonal * .019,
                  color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
                ),
              ],
            ),
          ],
        ),
      );

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRtl) ...[
            contentWidget,
            SizedBox(width: SizeConfig.width * .03),
            iconWidget,
          ] else ...[
            iconWidget,
            SizedBox(width: SizeConfig.width * .03),
            contentWidget,
          ],

          // CustomBackgroundWithChild(
          //   borderRadius: BorderRadius.circular(30),
          //   height: SizeConfig.width * .12,
          //   width: SizeConfig.width * .12,
          //   backgroundColor: const Color(0xFFF5F8FF),
          //   child: Icon(
          //     Icons.notifications_none,
          //     color: theme.colorScheme.primary,
          //     size: SizeConfig.width * .07,
          //   ),
          // ),

          // SizedBox(width: SizeConfig.width * .03),

          // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       CustomTextWidget(
          //         n.title,
          //         fontSize: SizeConfig.diagonal * .025,
          //         color: theme.colorScheme.secondary,
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //       ),

          //       SizedBox(height: SizeConfig.height * .003),

          //       CustomTextWidget(
          //         n.body,
          //         fontSize: SizeConfig.diagonal * .021,
          //         color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //        // textAlign: TextAlign.right,
          //        textAlign: TextAlign.start,
          //       ),

          //       SizedBox(height: SizeConfig.height * .004),

          //       Row(
          //         children: [
          //           Icon(
          //             Icons.access_time,
          //             size: SizeConfig.diagonal * .018,
          //             color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
          //           ),
          //           SizedBox(width: SizeConfig.width * .01),
          //           CustomTextWidget(
          //             n.date,
          //             fontSize: SizeConfig.diagonal * .019,
          //             color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    },
  );
}
