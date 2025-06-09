import 'package:flutter/material.dart';

class TextformfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool hideText;
  final String? labelText;
  final String? Function(String?)? validator;
  const TextformfieldWidget({
    super.key,
    this.controller,
    this.hideText = false,
    this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
