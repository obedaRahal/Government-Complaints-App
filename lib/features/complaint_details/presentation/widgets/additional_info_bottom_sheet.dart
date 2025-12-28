import 'package:complaints_app/core/common widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_state.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return BlocConsumer<AddDetailsCubit, AddDetailsState>(
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage ||
          prev.isSuccess != curr.isSuccess,
      listener: (context, state) {
        if (state.errorMessage != null) {
          showTopSnackBar(
            context,
            message: state.errorMessage!,
            isSuccess: false,
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? context.l10n.info_sent_success,
            isSuccess: true,
          );
          Navigator.of(context).pop();

          // إعادة تحميل تفاصيل الشكوى لتظهر التحديثات الجديدة
          // context.read<ComplaintDetailsCubit>().loadComplaintDetails(
          //   complaintId,
          // );
        }
      },

      builder: (context, state) {
        final addCubit = context.read<AddDetailsCubit>();

        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
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
                    context.l10n.more_info_bottom_sheet,
                    color: theme.colorScheme.primary,
                    fontSize: SizeConfig.height * .022,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  thickness: 2,
                  color: isDark ? AppColor.backGroundGrey : AppColor.lightGray,
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16, // ✅ بدل left
                    end: 16, // ✅ بدل right
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    top: 8,
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomDescriptionTextFiels(
                            controller: addCubit.descriptionController,
                            label: context.l10n.additional_description,
                            hint: context.l10n.additional_description_hint,
                            maxLines: 3,
                            maxLength: 512,
                            suffixIcon: Icons.layers_outlined,
                            keyboardType: TextInputType.multiline,

                            onChanged: addCubit.extraTextChanged,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 📎 مرفقات إضافية
                        ComplaintAttachmentField(
                          label: context.l10n.additional_attachment,
                          hint: context.l10n.additional_attachment_hint,
                          maxImages: 3,
                          onImagesSelected: addCubit.setExtraAttachments,
                        ),

                        const SizedBox(height: 16),

                        CustomButtonWidget(
                          width: double.infinity,
                          backgroundColor: theme.colorScheme.primary,
                          childHorizontalPad: SizeConfig.width * .07,
                          childVerticalPad: SizeConfig.height * .012,
                          borderRadius: 10,
                          onTap: () {
                            if (state.isSubmitting) return;
                            addCubit.submit(complaintId);
                          },
                          child: state.isSubmitting
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                )
                              : CustomTextWidget(
                                  context.l10n.confirm_of_dispatch, // ✅

                                  fontSize: SizeConfig.height * .025,
                                  color: theme.scaffoldBackgroundColor,
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
        );
      },
    );
  }
}
