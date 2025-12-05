import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_state.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/card_detais_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_history_item.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_information_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/divider_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/status_color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({super.key, required this.complaintId});
  final int complaintId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComplaintDetailsCubit, ComplaintDetailsState>(
      listenWhen: (prev, curr) =>
          prev.deleteErrorMessage != curr.deleteErrorMessage ||
          prev.isDeleteSuccess != curr.isDeleteSuccess,
      listener: (context, state) {
        if (state.deleteErrorMessage != null) {
          showTopSnackBar(
            context,
            message: state.deleteErrorMessage ?? "حدث خطأ غير متوقع",
            isSuccess: false,
          );
        }

        if (state.isDeleteSuccess) {
          showTopSnackBar(
            context,
            message: state.deleteSuccessMessage ?? "تم حذف هذه الشكوى بنجاح",
            isSuccess: true,
          );
          // رجوع لصفحة قائمة الشكاوى بعد الحذف
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
       
        if (state.isLoading && state.details == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null && state.details == null) {
          return Scaffold(body: Center(child: Text(state.errorMessage!)));
        }

        final details = state.details!;
        final info = details.complaintInfo;
        final attachments = details.attachments;
        final history = details.history;
        final statusColor = mapStatusColor(info.status);

        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(title: "تفاصيل الشكوى"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 22, right: 16),
                            child: CustomButtonWidget(
                              borderRadius: 16,
                              childHorizontalPad: 6,
                              childVerticalPad: 4,
                              backgroundColor: AppColor.lightPurple,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: CustomTextWidget(
                                  "مرفقات الشكوى",
                                  fontSize: SizeConfig.diagonal * .026,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 6,
                        ),
                        child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            itemCount: attachments.length,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            itemBuilder: (context, index) {
                              final attachment = attachments[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.network(
                                          attachment.path,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                            border: Border.all(
                                              color: AppColor.borderGrey,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Divider(thickness: 2.3, color: AppColor.dividerColor),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: CustomButtonWidget(
                          borderRadius: 16,
                          childHorizontalPad: 6,
                          childVerticalPad: 4,
                          backgroundColor: AppColor.lightPurple,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: CustomTextWidget(
                              "معلومات الشكوى",
                              fontSize: SizeConfig.diagonal * .026,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: Row(
                            children: [
                              ComplaintInformationWidget(
                                titleColor: AppColor.textColor,
                                hintColor: AppColor.greyText,
                                image: AppImage.grid,
                                title: 'النوع',
                                hint: info.complaintType,
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: AppColor.textColor,
                                hintColor: AppColor.greyText,
                                image: AppImage.layers,
                                title: 'الجهة الحكومية',
                                hint: info.agency,
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: AppColor.textColor,
                                hintColor: AppColor.greyText,
                                image: AppImage.houreGlass,
                                title: 'تاريخ الانشاء',
                                hint: info.createdAt.toString(),
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: AppColor.textColor,
                                hintColor: AppColor.greyText,
                                image: AppImage.group1,
                                title: 'رقم الشكوى',
                                hint: info.complaintNumber.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: CardDetaisWidget(
                          title: info.title,
                          status: info.status,
                          titleLocation: 'عنوان الشكوى',
                          location: info.locationText,
                          fontSize: SizeConfig.diagonal * .024,
                          titleDescreption: 'وصف الشكوى',
                          descreption: info.description,
                          statuseColor: statusColor,
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(thickness: 2.3, color: AppColor.dividerColor),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: CustomButtonWidget(
                          borderRadius: 16,
                          childHorizontalPad: 6,
                          childVerticalPad: 4,
                          backgroundColor: AppColor.lightPurple,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: CustomTextWidget(
                              "مراحل الشكوى",
                              fontSize: SizeConfig.diagonal * .026,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      if (history.isEmpty)
                        CustomTextWidget(
                          "لا يوجد سجل بعد لهذه الشكوى.",
                          color: AppColor.middleGrey,
                        )
                      else
                        Column(
                          children: history
                              .map((h) => ComplaintHistoryItem(history: h))
                              .toList(),
                        ),

                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          width: double.infinity,
                          backgroundColor: AppColor.middleGrey,
                          childHorizontalPad: SizeConfig.width * .07,
                          childVerticalPad: SizeConfig.height * .012,
                          borderRadius: 10,
                          onTap: () {
                            // showModalBottomSheet(
                            //   context: context,
                            //   isScrollControlled: true,
                            //   backgroundColor: Colors.transparent,
                            //   builder: (_) {
                            //     return AdditionalInfoBottomSheet(
                            //       complaintId: complaintId,
                            //     );
                            //   },
                            // );
                          },
                          child: CustomTextWidget(
                            "إرفاق معلومات إضافية",
                            fontSize: SizeConfig.height * .025,
                            color: AppColor.white,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: CustomButtonWidget(
                          width: double.infinity,
                          backgroundColor: AppColor.red,
                          childHorizontalPad: SizeConfig.width * .07,
                          childVerticalPad: SizeConfig.height * .012,
                          borderRadius: 10,
                          onTap: () {
                            if (state.isDeleting) return;

                            context
                                .read<ComplaintDetailsCubit>()
                                .deleteComplaint(complaintId);
                          },
                          child: state.isDeleting
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : CustomTextWidget(
                                  "حذف الشكوى",
                                  fontSize: SizeConfig.height * .025,
                                  color: AppColor.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
