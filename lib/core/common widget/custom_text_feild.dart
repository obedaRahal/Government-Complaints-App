
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.onSuffixTap
  });

  final TextEditingController? controller;
  final String? hint;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        maxLines: obscureText ? 1 : maxLines,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          //labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColor.middleGrey,
            fontFamily: AppFonts.tasees,
          ),

          suffixIcon: suffixIcon == null ? null : IconButton( onPressed: onSuffixTap ,icon: Icon(suffixIcon ,size: 20,)),
          suffixIconColor: Color(0xffACACAC),
          filled: true,
          fillColor: AppColor.grey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 229, 229, 229),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
