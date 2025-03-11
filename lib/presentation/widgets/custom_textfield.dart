import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/core/utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int maxline;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final VoidCallback? onTap;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.inputType,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.maxline = 1,
    this.inputFormatters,
    this.focusNode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: inputType,
          readOnly: readOnly,
          maxLines: maxline,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            focusColor: Colors.orange,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            suffixIcon: suffixIcon,
          ),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColor.greyText,
          ),
          validator: validator,
          textInputAction: TextInputAction.next,
          autofocus: false,
          onTap: onTap,
        ),
      ],
    );
  }
}
