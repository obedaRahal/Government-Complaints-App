import 'dart:io';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:flutter/foundation.dart';

class ComplaintAttachmentField extends StatefulWidget {
  final void Function(List<ImageFile>) onImagesSelected;

  const ComplaintAttachmentField({super.key, required this.onImagesSelected});

  @override
  State<ComplaintAttachmentField> createState() =>
      _ComplaintAttachmentFieldState();
}

class _ComplaintAttachmentFieldState extends State<ComplaintAttachmentField> {
  late final MultiImagePickerController controller;
  late FocusNode focusNode;
  bool isSlected = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          isSlected = false; // ← فقد التركيز
        });
      }
    });

    controller = MultiImagePickerController(
      maxImages: 3,
      images: const [],
      picker: (int pickCount, Object? params) async {
        final List<XFile>? picked = await _picker.pickMultiImage();

        if (picked == null || picked.isEmpty) return [];

        // تحديد العدد
        final limited = picked.take(pickCount).toList();

        // تحويل XFile → ImageFile
        return limited.map((xfile) {
          final path = xfile.path;
          final name = kIsWeb
              ? (xfile.name)
              : path.split(Platform.pathSeparator).last;

          final ext = name.split('.').last;

          return ImageFile(
            UniqueKey().toString(),
            name: name,
            extension: ext,
            path: path,
          );
        }).toList();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();

    super.dispose();
  }

  /// 🔥 هذه الدالة الجديدة (المطلوبة)
  Future<void> resetAndPickImages() async {
    // 1) حذف الصور القديمة
    controller.clearImages();
    focusNode.requestFocus();
    // 2) فتح المعرض من جديد
    await controller.pickImages();

    // 3) إرسال الصور للخارج
    widget.onImagesSelected(controller.images.toList());

    // 4) تحديث الواجهة
    setState(() {
      isSlected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagesList = controller.images.toList();
    final count = imagesList.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                "مرفقات الشكوى",
                fontSize: SizeConfig.diagonal * .032,
                color: AppColor.textColor,
              ),
              Text(
                count == 0 ? "3/0" : "3/$count",
                style: TextStyle(
                  fontFamily: AppFonts.tasees,
                  fontSize: 16,
                  color: AppColor.middleGrey,
                ),
              ),
            ],
          ),
        ),
        Focus(
          focusNode: focusNode,
          child: GestureDetector(
            onTap: resetAndPickImages,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: isSlected
                    ? Border.all(color: AppColor.primary)
                    : Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Icon(Icons.attach_file),
                  // const SizedBox(width: 0),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        count == 0
                            ? 'أدخل مرفقات الشكوى(اختياري)...'
                            : "تم اختيار $count ",
                        style: TextStyle(
                          fontFamily: AppFonts.tasees,
                          fontSize: 16,
                          color: AppColor.middleGrey,
                        ),
                      ),
                    ],
                  ),
                  if (count > 0)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: Color(0xffACACAC),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(
                              'الصور المختارة',
                              style: TextStyle(
                                fontFamily: AppFonts.tasees,
                                fontSize: 16,
                                color: AppColor.middleGrey,
                              ),
                            ),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: imagesList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                    ),
                                itemBuilder: (context, index) {
                                  final file = imagesList[index];
                                  return ImageFileView(
                                    imageFile: file,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(10),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "إغلاق",
                                  style: TextStyle(
                                    fontFamily: AppFonts.tasees,
                                    fontSize: 16,
                                    color: AppColor.middleGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (count == 0)
                    const Icon(Icons.attach_file, color: Color(0xffACACAC)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
