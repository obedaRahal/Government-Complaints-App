import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_information_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(
      viewportFraction: 0.90,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: "تفاصيل الشكوى"),
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
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: CustomTextWidget(
                        "مرفقات الشكوى",
                        fontSize: SizeConfig.diagonal * .026,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                //     Row(
                //                   children: List.generate(3, (index) {
                //                   //  final isSelected = index == selectedIndex;
                //                     return AnimatedContainer(
                //                       duration: const Duration(milliseconds: 300),
                //                       margin:
                //                           const EdgeInsets.symmetric(horizontal: 4),
                //                           width: 6,
                //                      // width: isSelected ? 14 : 6,
                //                       height: 6,
                //                       decoration: BoxDecoration(
                //                         color: isSelected
                //                             ? isDark
                //                                 ? AppColors.primaryDarkBlue
                //                                 : AppColors.primaryLightBlue
                //                             : isDark
                //                                 ? AppColors.navDarkGrey
                //                                 : AppColors.buttonLightGrey,
                //                         borderRadius: BorderRadius.circular(20),
                //                       ),
                //                     );
                //                   }),
                //                 ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.asset(
                                "assets/images/doctor.jpg",
                                fit: BoxFit.fill, // ما بيقص الصورة ولا يتمدد
                              ),
                            ),

                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
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
            Divider(thickness: 3, color: AppColor.dividerColor),
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  ComplaintInformationWidget(
                    titleColor: AppColor.textColor,
                    hintColor: AppColor.greyText,
                    image: AppImage.grid,
                    title: 'النوع',
                    hint: 'الصرف الصحي',
                  ),
                  DividerWidget(),
                  ComplaintInformationWidget(
                    titleColor: AppColor.textColor,
                    hintColor: AppColor.greyText,
                    image: AppImage.layers,
                    title: 'الجهة الحكومية',
                    hint: 'محافظة دمشق',
                  ),
                  DividerWidget(),
                  ComplaintInformationWidget(
                    titleColor: AppColor.textColor,
                    hintColor: AppColor.greyText,
                    image: AppImage.houreGlass,
                    title: 'تاريخ الانشاء',
                    hint: '12/01/2025',
                  ),
                  DividerWidget(),
                  ComplaintInformationWidget(
                    titleColor: AppColor.textColor,
                    hintColor: AppColor.greyText,
                    image: AppImage.group1,
                    title: 'رقم الشكوى',
                    hint: '123390',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
