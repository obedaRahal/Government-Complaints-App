import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_Card_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/top_part_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: HomeViewBody()));
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopPartHome(
          onChangedSearch: (value) {
            debugPrint("im at search field and val isss $value");
          },
          onTapProfile: () {
            debugPrint("go to profile");
          },
          onTapNotification: () {
            debugPrint("go to notification");
          },
        ),
        SizedBox(height: SizeConfig.height * .02),

        // العنوان + زر إضافة شكوى
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                "سجل الشكاوي",
                fontSize: SizeConfig.diagonal * .04,
                color: AppColor.black,
              ),
              CustomButtonWidget(
                borderRadius: 10,
                childHorizontalPad: 6,
                childVerticalPad: 4,
                backgroundColor: AppColor.lightPurple,
                onTap: () {
                  context.pushNamed(AppRouteRName.submitComplaintView);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: AppColor.primary,
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

        // قائمة الشكاوى (مع سكرول)
        // Expanded(
        //   child: ListView.separated(
        //     padding: const EdgeInsets.symmetric(horizontal: 16),
        //     itemCount: 4, // لاحقاً تربطها بالبيانات الحقيقية
        //     separatorBuilder: (_, __) =>
        //         SizedBox(height: SizeConfig.height * .005),
        //     itemBuilder: (context, index) {
        //       return const ComplaintCard(
        //         title: "انقطاع رسمي",
        //         statusText: "معلقة",
        //         statusColor: Colors.grey,
        //         number: "123123123123",
        //         description:
        //             "نص الوصف التجريبي للشكوىdf fdfdfdf dfdgff gfg  sgfghgh ويكون قابل للزيادة...",
        //       );
        //     },
        //   ),
        // ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatusEnum.loading &&
                  state.complaints.isEmpty) {
                return const Center(child: CircularProgressIndicator());
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
                    'لا توجد شكاوى حالياً',
                    color: AppColor.middleGrey,
                  ),
                );
              }

              final complaints = state.complaints;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: complaints.length + (state.canLoadMore ? 1 : 0),
                separatorBuilder: (_, __) =>
                    SizedBox(height: SizeConfig.height * .005),
                itemBuilder: (context, index) {
                  if (state.canLoadMore && index == complaints.length) {
                    // زر "عرض المزيد"
                    return Center(
                      child: CustomButtonWidget(
                        onTap: () {
                          context.read<HomeCubit>().loadMoreComplaints();
                        },
                        backgroundColor: AppColor.primary,
                        borderRadius: 10,
                        childVerticalPad: 4,
                        childHorizontalPad: 12,
                        child: state.isLoadingMore
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : CustomTextWidget(
                                'عرض المزيد',
                                color: AppColor.white,
                                fontSize: SizeConfig.diagonal * .025,
                              ),
                      ),
                    );
                  }

                  final complaint = complaints[index];

                  final statusText = _mapStatusText(complaint.currentStatus);
                  final statusColor = _mapStatusColor(complaint.currentStatus);

                  return ComplaintCard(
                    title: complaint.title,
                    statusText: statusText,
                    statusColor: statusColor,
                    number: complaint.number.toString(),
                    description: complaint.description,
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
          color: AppColor.black,
          maxLines: maxLines,
          overflow: maxLines != null ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}

String _mapStatusText(String status) {
  switch (status) {
    case 'new':
      return 'معلقة';
    case 'in_progress':
      return 'قيد المعالجة';
    case 'done':
      return 'تمت المعالجة';
    case 'rejected':
      return 'مرفوضة';
    default:
      return status;
  }
}

Color _mapStatusColor(String status) {
  switch (status) {
    case 'new':
      return AppColor.middleGrey;
    case 'in_progress':
      return AppColor.blue; // عرّفها في AppColor
    case 'done':
      return AppColor.green;
    case 'rejected':
      return AppColor.red;
    default:
      return AppColor.middleGrey;
  }
}
