import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/card_detais_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/complaint_information_widget.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/custom_date_info.dart';
import 'package:complaints_app/features/complaint_details/presentation/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
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
                            padding: const EdgeInsets.symmetric(horizontal: 14),
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
                                      fit: BoxFit
                                          .fill, // ما بيقص الصورة ولا يتمدد
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
                      // لو حابة يبدأ من اليمين مع سكرول لليسار:
                      // reverse: true,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: CardDetaisWidget(
                      title: 'بطء في خدمة النت المنزلي',
                      status: 'قيد المعالجة',
                      titleLocation: 'عنوان الشكوى',
                      location: 'شارع المجتهد مقابل مأكولات الشام',
                      fontSize: SizeConfig.diagonal * .024,
                      titleDescreption: 'وصف الشكوى',
                      descreption:
                          'اشغال رصيف شارع المجتهد الرئيسي من قبل بسطات البالة وعربات الترمس والفول النابت مما يؤدي الى عرقلة السير',
                      statuseColor: AppColor.blue,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),

                    child: CustomDateInfo(
                      date: 'الخميس - 2025/10/22',
                      status: 'معلقة',
                      statusColor: AppColor.statusProcessing,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: CardDetaisWidget(
                      title: "الأحد - 2025/10/22",
                      status: 'قيد المعالجة',
                      fontSize: SizeConfig.diagonal * .016,
                      titleDescreption: 'ملاحظات',
                      descreption:
                          'اشغال رصيف شارع المجتهد الرئيسي من قبل بسطات البالة وعربات الترمس والفول النابت مما يؤدي الى عرقلة السير',
                      statuseColor: AppColor.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),

                    child: CustomDateInfo(
                      date: 'الخميس - 2025/10/22',
                      status: 'تمت معالجتها',
                      statusColor: AppColor.green,
                    ),
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
                      onTap: () {},
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
                      onTap: () {},
                      child: CustomTextWidget(
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
  }
}
