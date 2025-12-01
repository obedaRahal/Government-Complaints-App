import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_Card_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_card_shimmer_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/top_part_home.dart';
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
              // مسح الـ stack والذهاب للّوج إن
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
    return Column(
      children: [
        TopPartHome(
          onChangedSearch: (value) {
            context.read<HomeCubit>().searchTextChanged(value);
          },
          onTapLogout: () {
            debugPrint("loggg outtttt");
            context.read<LogoutCubit>().logOutSubmitted();
          },
          onTapNotification: () {
            debugPrint("go to notification");
          },
          onSearchTap: (query) {
            // نرسل النص مباشرة من الـ HomeSearchField
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
                color: AppColor.black,
              ),
              CustomButtonWidget(
                borderRadius: 10,
                childHorizontalPad: SizeConfig.width * .005,
                childVerticalPad: SizeConfig.height * .002,
                backgroundColor: AppColor.lightPurple,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
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
                      ),
                    );
                  }

                  final complaint = complaints[index];

                  final statusText = complaint.currentStatus;
                  final statusColor = _mapStatusColor(complaint.currentStatus);

                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(AppRouteRName.complaintDetailsView);
                    },
                    child: ComplaintCard(
                      title: complaint.title,
                      statusText: statusText,
                      statusColor: statusColor,
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

Color _mapStatusColor(String status) {
  switch (status) {
    case 'معلقة':
      return AppColor.middleGrey;
    case 'قيد المعالجة':
      return AppColor.blue;
    case 'تم معالجتها':
      return AppColor.green;
    case 'تم رفضها':
      return AppColor.red;
    default:
      return AppColor.middleGrey;
  }
}
