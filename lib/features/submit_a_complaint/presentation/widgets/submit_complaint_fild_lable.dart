import 'package:complaints_app/core/common%20widget/custom_submit_complaint_field.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class SubmitComplaintFildLable extends StatelessWidget {
  const SubmitComplaintFildLable({
    super.key,
    required this.label,
    this.selectedType,
    required this.items,
    required this.onChanged,
    required this.hint,
  });
  final String label;
  final String hint;
  final List<String> items;
  final String? selectedType;
  final dynamic Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          label,
          fontSize: SizeConfig.diagonal * .032,
          color:theme.colorScheme.secondary,
        ),
        SizedBox(height: SizeConfig.height * .01),
        SubmitComplaintTypeField(
          hint: hint,
          selectedType: selectedType,
          items: items,
          onChanged: onChanged,
          //  (value) {
          //   context.read<SubmitComplaintCubit>().selectType(value);
          // },
        ),
      ],
    );
  }
}
