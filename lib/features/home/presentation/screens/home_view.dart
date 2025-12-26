import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/common%20widget/switch_theme.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/status_color_helper.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_Card_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_card_shimmer_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/show_notification_bottom_sheet.dart';
import 'package:complaints_app/features/home/presentation/widgets/top_part_home.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_cubit.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LogoutCubit, LogoutState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == LogoutStatusEnum.success) {
              context.goNamed(AppRouteRName.welcomeView);
            }

            if (state.status == LogoutStatusEnum.error) {
              showTopSnackBar(
                context,
                message: state.message ?? 'حدث خطأ أثناء تسجيل الخروج',
                isSuccess: false,
              );
            }
          },
          child: HomeViewBody(),
        ),
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Column(
      children: [
        TopPartHome(
          onChangedSearch: (value) {
            context.read<HomeCubit>().searchTextChanged(value);
          },
          onTapLogout: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (bottomSheetContext) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    final theme = Theme.of(bottomSheetContext);
                    final isDark = state.mode == ThemeMode.dark;
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: SafeArea(
                          top: false,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Container(
                                  width: 45,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColor.borderFieldDark
                                        : AppColor.middleGrey,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CustomTextWidget(
                                    "الاعدادات",
                                    color: theme.colorScheme.primary,
                                    fontSize: SizeConfig.height * .022,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  thickness: 2,
                                  color: isDark
                                      ? AppColor.backGroundGrey
                                      : AppColor.lightGray,
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      CustomTextWidget(
                                        "هل تريد تسجيل الخروج؟",
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  // endIndent: 120,
                                  // //indent: 20,
                                  thickness: 2,
                                  color: isDark
                                      ? AppColor.backGroundGrey
                                      : AppColor.lightGray,
                                ),
                                InkWell(
                                  onTap: () {
                                    debugPrint("loggg outtttt");
                                    context
                                        .read<LogoutCubit>()
                                        .logOutSubmitted();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        CustomTextWidget(
                                          'تسجيل الخروج',
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Divider(
                                  // endIndent: 120,
                                  // //indent: 20,
                                  thickness: 2,
                                  color: isDark
                                      ? AppColor.backGroundGrey
                                      : AppColor.lightGray,
                                ),
                                ThemeSwitchTile(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },

          onTapNotification: () {
            // final dummyNotifications = <NotificationItem>[
            //   const NotificationItem(
            //     title: 'تم تسجيل شكوى جديدة',
            //     body:
            //         'تم استلام شكواك وسيتم تحويلها إلى الجهة المختصة للمعالجة.',
            //     date: 'منذ دقيقة',
            //   ),
            //   const NotificationItem(
            //     title: 'تحديث حالة الشكوى رقم 11',
            //     body: 'تم تغيير حالة الشكوى إلى: قيد المعالجة.',
            //     date: 'قبل 10 دقائق',
            //   ),
            //   const NotificationItem(
            //     title: 'تم إغلاق الشكوى رقم 8',
            //     body: 'تمت معالجة الشكوى وإغلاقها. شكراً لتعاونك.',
            //     date: 'اليوم - 10:30 ص',
            //   ),
            // ];

            showNotificationsBottomSheet(parentContext: context);
          },

          onSearchTap: (query) {
            context.read<HomeCubit>().searchComplaint(query);
          },
          onTapCancel: () {
            context.read<HomeCubit>().cancelSearch();
          },
        ),

        SizedBox(height: SizeConfig.height * .02),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextWidget(
                "سجل الشكاوي",
                fontSize: SizeConfig.diagonal * .038,
                color: theme.colorScheme.secondary,
              ),
              CustomButtonWidget(
                borderRadius: 10,
                childHorizontalPad: SizeConfig.width * .005,
                childVerticalPad: SizeConfig.height * .002,
                backgroundColor: theme.colorScheme.onPrimary,
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  final result = await context.pushNamed<bool>(
                    AppRouteRName.submitComplaintView,
                  );

                  if (result == true) {
                    context.read<HomeCubit>().loadComplaints();
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: theme.colorScheme.primary,
                      size: SizeConfig.height * .025,
                    ),
                    SizedBox(width: SizeConfig.width * .01),
                    CustomTextWidget(
                      "اضافة شكوى جديدة",
                      fontSize: SizeConfig.diagonal * .025,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: SizeConfig.height * .01),

        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatusEnum.loading &&
                  state.complaints.isEmpty) {
                return const Center(child: ComplaintsShimmerList());
              }

              if (state.status == HomeStatusEnum.error &&
                  state.complaints.isEmpty) {
                return Center(
                  child: CustomTextWidget(
                    state.message ?? 'حدث خطأ ما',
                    color: AppColor.red,
                  ),
                );
              }

              if (state.complaints.isEmpty) {
                return Center(
                  child: CustomTextWidget(
                    state.isSearchMode
                        ? 'لا يوجد شكوى بهذا الرقم'
                        : 'لا توجد شكاوى حالياً',
                    color: AppColor.middleGrey,
                  ),
                );
              }

              final complaints = state.complaints;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: complaints.length + (state.canLoadMore ? 1 : 0),
                separatorBuilder: (_, _) =>
                    SizedBox(height: SizeConfig.height * .005),
                itemBuilder: (context, index) {
                  if (state.canLoadMore && index == complaints.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButtonWidget(
                          onTap: () {
                            context.read<HomeCubit>().loadMoreComplaints();
                          },
                          backgroundColor: theme.colorScheme.primary,
                          borderRadius: 10,
                          childVerticalPad: 4,
                          childHorizontalPad: 12,
                          child: state.isLoadingMore
                              ? SizedBox(
                                  // height: 20,
                                  // width: 20,
                                  child: CircularProgressIndicator(
                                    padding: EdgeInsets.symmetric(
                                      //vertical: 10,
                                      horizontal: 20,
                                    ),
                                    strokeWidth: 2,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                )
                              : CustomTextWidget(
                                  'عرض المزيد',
                                  color: theme.scaffoldBackgroundColor,
                                  fontSize: SizeConfig.diagonal * .025,
                                ),
                        ),
                      ),
                    );
                  }

                  final complaint = complaints[index];

                  final statusText = complaint.currentStatus;
                  final statusColor = mapStatusColor(complaint.currentStatus);
                  final statusColorDark = mapStatusColorDark(
                    complaint.currentStatus,
                  );

                  return GestureDetector(
                    onTap: () async {
                      final complaintId = complaint.id;

                      final result = await context.pushNamed<bool>(
                        AppRouteRName.complaintDetailsView,
                        pathParameters: {'id': complaintId.toString()},
                      );

                      if (result == true) {
                        context.read<HomeCubit>().loadComplaints();
                      }
                    },

                    child: ComplaintCard(
                      title: complaint.title,
                      statusText: statusText,
                      statusColor: isDark ? statusColorDark : statusColor,
                      number: complaint.number.toString(),
                      description: complaint.description,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class LabelColumnTitleValue extends StatelessWidget {
  const LabelColumnTitleValue({
    super.key,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          label,
          fontSize: SizeConfig.diagonal * .02,
          color: AppColor.middleGrey,
        ),
        CustomTextWidget(
          value,
          textAlign: TextAlign.right,
          fontSize: SizeConfig.diagonal * .022,
          color: theme.colorScheme.onSecondary,
          maxLines: maxLines,
          overflow: maxLines != null ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}

// Color _mapStatusColor(String status) {
//   switch (status) {
//     case 'معلقة':
//       return AppColor.middleGrey;
//     case 'قيد المعالجة':
//       return AppColor.blue;
//     case 'تم معالجتها':
//       return AppColor.green;
//     case 'تم رفضها':
//       return AppColor.red;
//     default:
//       return AppColor.middleGrey;
//   }
// }

// Color _mapStatusColorDark(String status) {
//   switch (status) {
//     case 'معلقة':
//       return AppColor.greyDark;
//     case 'قيد المعالجة':
//       return AppColor.blueDark;
//     case 'تم معالجتها':
//       return AppColor.greenDark;
//     case 'تم رفضها':
//       return AppColor.redDark;
//     default:
//       return AppColor.middleGrey;
//   }
// }
