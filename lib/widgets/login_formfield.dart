import 'package:flutter/material.dart';
import 'package:tp_archi_mobile/utils/form_style.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hasAsterisks;

  const LoginTextField(
      {Key? key,
        required this.controller,
        required this.hintText,
        this.validator,
        this.hasAsterisks = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          obscureText: hasAsterisks,
          validator: (value) {
            if (validator != null) return validator!(value);
          },
          controller: controller,
          style: FormStyle.textStyle, // Appliquez le style du texte
          decoration: FormStyle.inputDecoration('$hintText'),
        )
    );
  }
}
