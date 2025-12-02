import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/manager/submit_complaint_state.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/manager/submit_complaint_cubit.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/complaint_attachment_field.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/custom_description_text_fiels.dart';
import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/submit_complaint_fild_lable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubmitComplaintView extends StatelessWidget {
  const SubmitComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmitComplaintCubit, SubmitComplaintState>(
      listenWhen: (prev, curr) =>
          prev.submitErrorMessage != curr.submitErrorMessage ||
          prev.isSubmitSuccess != curr.isSubmitSuccess,
      listener: (context, state) {
        if (state.submitErrorMessage != null) {
          showTopSnackBar(
            context,
            message: state.submitErrorMessage ?? "حدث خطأ غير متوقع",
            isSuccess: false,
          );
        }

        if (state.isSubmitSuccess) {
          showTopSnackBar(
            context,
            message: state.submitSuccessMessage ?? "تم إرسال الشكوى بنجاح",
            isSuccess: true,
          );
          //context.read<SubmitComplaintCubit>().resetForm();

          // context.pop();
          //Navigator.pop(context);
          GoRouter.of(context).pop(true);
        }
      },
      builder: (context, state) {
        final cubit = context.read<SubmitComplaintCubit>();

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 29),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      //textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12, bottom: 14),
                          child: CustomTextWidget(
                            "تقديم شكوى",
                            fontSize: SizeConfig.diagonal * .04,
                            color: AppColor.textColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 28,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "اسم الشكوى",
                    hint: "ادخل اسم للشكوى الخاصة بك...",
                    suffixIcon: Icons.edit_document,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      context.read<SubmitComplaintCubit>().titleChanged(value);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Builder(
                    builder: (context) {
                      if (state.isLoadingComplaintTypes) {
                        return Opacity(
                          opacity: 0.6,
                          child: SubmitComplaintFildLable(
                            selectedType: null,
                            items: const [],
                            label: "نوع الشكوى",
                            hint: "جارٍ تحميل أنواع الشكاوى...",
                            onChanged: (String? p1) {},
                          ),
                        );
                      }
                      if (state.complaintTypesErrorMessage != null) {
                        return CustomTextWidget(
                          state.complaintTypesErrorMessage!,
                          color: Colors.red,
                          fontSize: SizeConfig.diagonal * .028,
                        );
                      }
                      return SubmitComplaintFildLable(
                        selectedType: state.selectedComplaintTypeName,
                        items: state.complaintTypes
                            .map((agency) => agency.name)
                            .toList(),
                        hint: "اختار نوع الشكوى...",
                        label: "نوع الشكوى",
                        onChanged: cubit.selectComplaintTypeEntity,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Builder(
                    builder: (context) {
                      if (state.isLoadingAgencies) {
                        return Opacity(
                          opacity: 0.6,
                          child: SubmitComplaintFildLable(
                            selectedType: null,
                            items: const [],
                            label: "الجهة الحكومية",
                            hint: "جارٍ تحميل الجهات...",
                            onChanged: (String? p1) {},
                          ),
                        );
                      }

                      if (state.agenciesErrorMessage != null) {
                        return CustomTextWidget(
                          state.agenciesErrorMessage!,
                          color: Colors.red,
                          fontSize: SizeConfig.diagonal * .028,
                        );
                      }

                      return SubmitComplaintFildLable(
                        selectedType: state.selectedAgencyName,
                        items: state.agencies
                            .map((agency) => agency.name)
                            .toList(),
                        label: "الجهة الحكومية",
                        hint: "اختر الجهة الحكومية...",
                        onChanged: cubit.selectGovEntity,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: CustomDescriptionTextFiels(
                    controller: cubit.descriptionController,
                    maxLines: 3,
                    maxLength: 512,
                    suffixIcon: Icons.layers_outlined,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      context.read<SubmitComplaintCubit>().descriptionChanged(
                        value,
                      );
                    },
                    hint: "ادخل وصفا للمشكلة التي تواجهها...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "عنوان الشكوى",
                    hint: "ادخل عنوان الشكوى...",
                    suffixIcon: Icons.pin_drop_outlined,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      context.read<SubmitComplaintCubit>().locationChanged(
                        value,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ComplaintAttachmentField(
                    onImagesSelected: (images) {
                      context.read<SubmitComplaintCubit>().setAttachments(
                        images,
                      );
                    },
                  ),
                ),

                SizedBox(height: SizeConfig.height / 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 16,
                  ),
                  child:
                      BlocBuilder<SubmitComplaintCubit, SubmitComplaintState>(
                        builder: (context, state) {
                          if (state.isSubmitting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return CustomButtonWidget(
                            width: double.infinity,
                            backgroundColor: AppColor.primary,
                            childHorizontalPad: SizeConfig.width * .07,
                            childVerticalPad: SizeConfig.height * .012,
                            borderRadius: 10,
                            onTap: () {
                              context
                                  .read<SubmitComplaintCubit>()
                                  .submitComplaint();
                            },
                            child: CustomTextWidget(
                              "تأكيد الارسال",
                              fontSize: SizeConfig.height * .025,
                              color: AppColor.white,
                            ),
                          );
                        },
                      ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
