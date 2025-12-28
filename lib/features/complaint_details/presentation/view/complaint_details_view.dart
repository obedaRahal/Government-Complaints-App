import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/localization/localization_ext.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/domain/use_case/add_complaint_details_use_case.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_cubit.dart';
import 'package:complaints_app/features/complaint_details/presentation/manager/complaint_details_state.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/additional_info_bottom_sheet.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/card_detais_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_history_item.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_information_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/divider_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/status_color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({
    super.key,
    required this.complaintId,
    required this.addComplaintDetailsUseCase,
  });

  final int complaintId;
  final AddComplaintDetailsUseCase addComplaintDetailsUseCase;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final isEn = Localizations.localeOf(context).languageCode == 'en';

    return BlocConsumer<ComplaintDetailsCubit, ComplaintDetailsState>(
      listenWhen: (prev, curr) =>
          prev.deleteErrorMessage != curr.deleteErrorMessage ||
          prev.isDeleteSuccess != curr.isDeleteSuccess,
      listener: (context, state) {
        if (state.deleteErrorMessage != null) {
          showTopSnackBar(
            context,
            message: state.deleteErrorMessage ?? context.l10n.unexpected_error,
            isSuccess: false,
          );
        }

        if (state.isDeleteSuccess) {
          showTopSnackBar(
            context,
            message:
                state.deleteSuccessMessage ??
                context.l10n.delete_complaint_done,
            isSuccess: true,
          );
          //Navigator.of(context).pop();
          context.pop(true);
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
        final attachments = details.attachments ?? [];

        final history = details.history;
        final statusColor = mapStatusColor(info.status);
        final statusColorDark = mapStatusColorDark(info.status);

        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(title: context.l10n.top_bar_complaints_details),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (attachments.isNotEmpty) ...[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 22,
                                start: 16,
                              ),
                              child: CustomButtonWidget(
                                borderRadius: 16,
                                childHorizontalPad: 6,
                                childVerticalPad: 4,
                                backgroundColor: theme.colorScheme.onPrimary,
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: CustomTextWidget(
                                    context.l10n.complaint_attachments,
                                    fontSize:
                                        SizeConfig.diagonal *
                                        (isEn ? .022 : .026),
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
                            height: 132,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: attachments.length,
                              reverse: false,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
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
                                          aspectRatio: 16 / 10,
                                          child: Image.network(
                                            attachment.path,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
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

                        Divider(
                          thickness: 2.3,
                          color: isDark
                              ? AppColor.backGroundGrey
                              : AppColor.dividerColor,
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 22,
                          start: 16,
                        ),
                        child: CustomButtonWidget(
                          borderRadius: 16,
                          childHorizontalPad: 6,
                          childVerticalPad: 4,
                          backgroundColor: theme.colorScheme.onPrimary,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: CustomTextWidget(
                              context.l10n.complaint_info,
                              fontSize:
                                  SizeConfig.diagonal * (isEn ? .022 : .026),
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
                          reverse: isRtl,
                          child: Row(
                            children: [
                              ComplaintInformationWidget(
                                titleColor: theme.colorScheme.secondary,
                                hintColor: AppColor.greyText,
                                image: AppImage.grid,
                                title: context.l10n.complaint_type,
                                hint: info.complaintType,
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: theme.colorScheme.secondary,
                                hintColor: AppColor.greyText,
                                image: AppImage.layers,
                                title: context.l10n.government_agency,
                                hint: info.agency,
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: theme.colorScheme.secondary,
                                hintColor: AppColor.greyText,
                                image: AppImage.houreGlass,
                                title: context.l10n.date_of_ceartion,
                                hint: info.createdAt.toString(),
                              ),
                              DividerWidget(),
                              ComplaintInformationWidget(
                                titleColor: theme.colorScheme.secondary,
                                hintColor: AppColor.greyText,
                                image: AppImage.group1,
                                title: context.l10n.complaint_number,
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
                          titleLocation: context.l10n.complaint_location,
                          location: info.locationText,
                          fontSize: SizeConfig.diagonal * .024,
                          titleDescreption: context.l10n.complaint_description,
                          descreption: info.description,
                          statuseColor: isDark ? statusColorDark : statusColor,
                        ),
                      ),

                      const SizedBox(height: 16),
                      Divider(
                        thickness: 2.3,
                        color: isDark
                            ? AppColor.backGroundGrey
                            : AppColor.dividerColor,
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 22,
                          start: 16,
                        ),
                        child: CustomButtonWidget(
                          borderRadius: 16,
                          childHorizontalPad: 6,
                          childVerticalPad: 4,
                          backgroundColor: theme.colorScheme.onPrimary,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: CustomTextWidget(
                              context.l10n.complaints_history,
                              fontSize:
                                  SizeConfig.diagonal * (isEn ? .022 : .026),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      if (history.isEmpty)
                        CustomTextWidget(
                          context.l10n.not_found_history,
                          color: AppColor.middleGrey,
                        )
                      else
                        Column(
                          children: history
                              .map((h) => ComplaintHistoryItem(history: h))
                              .toList(),
                        ),

                      const SizedBox(height: 40),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButtonWidget(
                          width: double.infinity,
                          backgroundColor: isDark
                              ? AppColor.primaryDark
                              : AppColor.middleGrey,
                          childHorizontalPad: SizeConfig.width * .07,
                          childVerticalPad: SizeConfig.height * .012,
                          borderRadius: 10,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (bottomSheetContext) {
                                return BlocProvider<AddDetailsCubit>(
                                  create: (_) => AddDetailsCubit(
                                    addComplaintDetailsUseCase,
                                  ),
                                  child: AdditionalInfoBottomSheet(
                                    complaintId: complaintId,
                                  ),
                                );
                              },
                            );
                          },
                          child: CustomTextWidget(
                            context.l10n.add_more_attachments,
                            fontSize: SizeConfig.height * .025,
                            color: theme.scaffoldBackgroundColor,
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
                          backgroundColor: isDark
                              ? AppColor.redDark
                              : AppColor.red,
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
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                )
                              : CustomTextWidget(
                                  context.l10n.delete_complaint,
                                  fontSize: SizeConfig.height * .025,
                                  color: theme.scaffoldBackgroundColor,
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
