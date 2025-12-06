import 'package:complaints_app/core/common widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_state.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_cubit.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/complaint_attachment_field.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/custom_description_text_fiels.dart';
import 'package:complaints_app/core/common widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalInfoBottomSheet extends StatelessWidget {
  const AdditionalInfoBottomSheet({super.key, required this.complaintId});
  final int complaintId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDetailsCubit, AddDetailsState>(
      // 🧠 مهم جداً: ما نسمع إلا لما تتغير الأخطاء أو النجاح
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage ||
          prev.isSuccess != curr.isSuccess,
      listener: (context, state) {
        // 🔴 في حال فشل
        if (state.errorMessage != null) {
          showTopSnackBar(
            context,
            message: state.errorMessage!, // 👈 بدون ?? "حدث خطأ غير متوقع"
            isSuccess: false,
          );
        }

        // ✅ في حال نجاح
        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message:
                state.successMessage ?? "تم إرسال المعلومات الإضافية بنجاح",
            isSuccess: true,
          );

          // اغلاق الـ BottomSheet
          Navigator.of(context).pop();

          // إعادة تحميل تفاصيل الشكوى لتظهر التحديثات الجديدة
          // context.read<ComplaintDetailsCubit>().loadComplaintDetails(
          //   complaintId,
          // );
        }
      },

      builder: (context, state) {
        final addCubit = context.read<AddDetailsCubit>();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 45,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColor.middleGrey,
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
                      color: AppColor.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomTextWidget(
                      "معلومات إضافية",
                      color: AppColor.primary,
                      fontSize: SizeConfig.height * .022,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      top: 8,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 📝 حقل الوصف الإضافي
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: CustomDescriptionTextFiels(
                              controller: addCubit.descriptionController,
                              label: "وصف إضافي",
                              maxLines: 3,
                              maxLength: 512,
                              suffixIcon: Icons.layers_outlined,
                              keyboardType: TextInputType.multiline,
                              hint: "أدخل وصفاً إضافياً لهذه الشكوى...",
                              onChanged: addCubit.extraTextChanged,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // 📎 مرفقات إضافية
                          ComplaintAttachmentField(
                            label: "مرفقات إضافية",
                            hint: "أدخل مرفقات إضافية (اختياري)...",
                            maxImages: 3,
                            onImagesSelected:
                                addCubit.setExtraAttachments, // 👈 ليست وحدة بس
                          ),

                          const SizedBox(height: 16),

                          // 🔘 زر تأكيد الإرسال
                          CustomButtonWidget(
                            width: double.infinity,
                            backgroundColor: AppColor.primary,
                            childHorizontalPad: SizeConfig.width * .07,
                            childVerticalPad: SizeConfig.height * .012,
                            borderRadius: 10,
                            onTap: () {
                              if (state.isSubmitting) return;
                              addCubit.submit(complaintId);
                            },
                            child: state.isSubmitting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : CustomTextWidget(
                                    "تأكيد الارسال",
                                    fontSize: SizeConfig.height * .025,
                                    color: AppColor.white,
                                  ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
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
}
