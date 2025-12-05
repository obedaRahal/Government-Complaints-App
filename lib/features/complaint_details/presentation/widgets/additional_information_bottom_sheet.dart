// import 'package:complaints_app/core/common widget/custom_button_widget.dart';
// import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_cubit.dart';
// import 'package:complaints_app/features/complaint_details/presentation/manager/add_details_state.dart';

// import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/complaint_attachment_field.dart';
// import 'package:complaints_app/features/submit_a_complaint/presentation/widgets/custom_description_text_fiels.dart';

// import 'package:flutter/material.dart';
// import 'package:complaints_app/core/theme/color/app_color.dart';
// import 'package:complaints_app/core/common widget/custom_text_widget.dart';
// import 'package:complaints_app/core/utils/media_query_config.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AdditionalInfoBottomSheet extends StatelessWidget {
//   const AdditionalInfoBottomSheet({super.key, required this.complaintId});

//   final int complaintId;

//   @override
//   Widget build(BuildContext context) {
//     // كيوبت إضافة المعلومات الإضافية
//     final addCubit = context.read<AddDetailsCubit>();

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: SafeArea(
//           top: false,
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 8),

//                 // الـ handle الصغير
//                 Container(
//                   width: 45,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: AppColor.middleGrey,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // عنوان "معلومات إضافية"
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColor.primary.withOpacity(.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: CustomTextWidget(
//                     "معلومات إضافية",
//                     color: AppColor.primary,
//                     fontSize: SizeConfig.height * .022,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // 📝 حقل الوصف الإضافي
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 0,
//                             vertical: 4,
//                           ),
//                           child: CustomDescriptionTextFiels(
//                             label: "وصف إضافي",
                            
//                             maxLines: 3,
//                             maxLength: 512,
//                             suffixIcon: Icons.layers_outlined,
//                             keyboardType: TextInputType.multiline,
//                            onChanged: addCubit.extraTextChanged,
//                             hint: "أدخل وصفاً إضافياً للمشكلة...",
//                           ),
//                         ),

//                         // 📎 حقل المرفق الإضافي
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 0,
//                             vertical: 4,
//                           ),
//                           child: ComplaintAttachmentField(
//                             label: "مرفق إضافي",
//                             hint: "أدخل مرفقاً إضافياً للشكوى (اختياري)...",
//                             maxImages: 1,
//                             onImagesSelected: addCubit.setExtraAttachments,

//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // 🔘 زر تأكيد الإرسال (مربوط مع حالة الكيوبت)
//                         BlocBuilder<AddDetailsCubit, AddDetailsState>(
//                           builder: (context, state) {
//                             return CustomButtonWidget(
//                               width: double.infinity,
//                               backgroundColor: AppColor.primary,
//                               borderRadius: 10,
//                               // دايمًا في كولباك
//                               onTap: () {
//                                 if (state.isSubmitting)
//                                   return; // لو عم يرسل، تجاهل الضغط
//                                 addCubit.submit(complaintId);
//                               },
//                               child: state.isSubmitting
//                                   ? const SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                       ),
//                                     )
//                                   : CustomTextWidget(
//                                       "إرسال المعلومات الإضافية",
//                                       fontSize: SizeConfig.height * .022,
//                                       color: AppColor.white,
//                                     ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
