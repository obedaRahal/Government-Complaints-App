import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius = 10,
    this.hintFontSize = 16,
    this.onChanged,
    this.validator,
    this.onSuffixTap,
    this.initialText,
  });

  final TextEditingController? controller;
  final String? hint;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final double borderRadius;
  final double hintFontSize;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    return SizedBox(
      //height: 50,
      child: TextFormField(
        key: initialText != null ? ValueKey(initialText) : null,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        maxLines: obscureText ? 1 : maxLines,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          color: theme.colorScheme.secondary,
          fontFamily: AppFonts.tasees,
          fontSize: hintFontSize,
        ),
        decoration: InputDecoration(
          //labelText: label,
          hintText: hint,
          counterText: "",
          hintStyle: TextStyle(
            color: inputTheme.hintStyle!.color,
            fontFamily: AppFonts.tasees,
            fontSize: hintFontSize,
          ),

          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(suffixIcon, size: 20),
                ),

          prefix: prefixIcon == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(prefixIcon, size: 20),
                ),
          suffixIconColor: isDark ? AppColor.middleGreyDark : Color(0xffACACAC),
          filled: true,
          fillColor: inputTheme.fillColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: inputTheme.border!.borderSide.color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: inputTheme.focusedBorder!.borderSide.color,
            ),
          ),
        ),
      ),
    );
  }
}
