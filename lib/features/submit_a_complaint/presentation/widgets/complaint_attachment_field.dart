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
  const ComplaintAttachmentField({
    super.key,
    required this.onImagesSelected,

    this.label,
    this.hint,
    this.maxImages = 3,
    this.initialImages = const [],
  });

  final void Function(List<ImageFile>) onImagesSelected;

  final String? label;

  final String? hint;

  final int maxImages;

  final List<ImageFile> initialImages;

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
          isSlected = false;
        });
      }
    });

    controller = MultiImagePickerController(
      maxImages: widget.maxImages,
      images: widget.initialImages,
      picker: (int pickCount, Object? params) async {
        final List<XFile>? picked = await _picker.pickMultiImage();

        if (picked == null || picked.isEmpty) return [];

        final limited = picked.take(pickCount).toList();

        return limited.map((xfile) {
          final path = xfile.path;
          final name = kIsWeb
              ? xfile.name
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

  Future<void> resetAndPickImages() async {
    controller.clearImages();
    focusNode.requestFocus();

    await controller.pickImages();

    widget.onImagesSelected(controller.images.toList());

    setState(() {
      isSlected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagesList = controller.images.toList();
    final count = imagesList.length;

    final labelText = widget.label ?? "مرفقات الشكوى";
    final hintText = widget.hint ?? "أدخل مرفقات الشكوى(اختياري)...";
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                labelText,
                fontSize: SizeConfig.diagonal * .032,
                color: theme.colorScheme.secondary,
              ),
              Text(
                "${widget.maxImages}/$count",
                style: TextStyle(
                  fontFamily: AppFonts.tasees,
                  fontSize: 16,
                  color: isDark ? AppColor.whiteDark : AppColor.middleGrey,
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
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColor.backGroundGrey : AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: isSlected
                    ? Border.all(
                        color: theme
                            .inputDecorationTheme
                            .focusedBorder!
                            .borderSide
                            .color,
                      )
                    : Border.all(
                        color:
                            theme.inputDecorationTheme.border!.borderSide.color,
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        count == 0 ? hintText : "تم اختيار $count",
                        style: TextStyle(
                          fontFamily: AppFonts.tasees,
                          fontSize: 16,
                          color: isDark
                              ? AppColor.middleGreyDark
                              : AppColor.middleGrey,
                        ),
                      ),
                    ],
                  ),
                  if (count > 0)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.photo_library_outlined,
                        color: isDark
                            ? AppColor.middleGreyDark
                            : AppColor.middleGrey,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(
                              'الصور المختارة',
                              style: TextStyle(
                                fontFamily: AppFonts.tasees,
                                fontSize: 16,
                                color: isDark
                                    ? AppColor.middleGreyDark
                                    : AppColor.middleGrey,
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
                                child: Text(
                                  "إغلاق",
                                  style: TextStyle(
                                    fontFamily: AppFonts.tasees,
                                    fontSize: 16,
                                    color: isDark
                                        ? AppColor.middleGreyDark
                                        : AppColor.middleGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (count == 0)
                    Icon(
                      Icons.attach_file,
                      color: isDark
                          ? AppColor.middleGreyDark
                          : AppColor.middleGrey,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
