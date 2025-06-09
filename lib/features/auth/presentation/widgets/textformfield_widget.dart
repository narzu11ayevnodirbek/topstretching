import 'package:flutter/material.dart';

class TextformfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool hideText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  const TextformfieldWidget({
    super.key,
    this.controller,
    this.hideText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hideText,
      style: TextStyle(color: Color(0xFF828282), fontSize: 16),
      cursorColor: Color(0xFF828282),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF828282), fontSize: 16),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
      ),
      validator: validator,
    );
  }
}
