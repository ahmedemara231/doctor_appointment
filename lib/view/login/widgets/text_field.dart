import 'package:flutter/material.dart';
import '../../../helpers/base_widgets/text_field.dart';

class AuthTextFields extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final TextEditingController cont;
  final String? Function(String?) validation;

  const AuthTextFields({Key? key,
    required this.hintText,
    required this.obscureText,
    required this.cont,
    required this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TFF(
      obscureText: obscureText,
      controller: cont,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      validator: validation,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(16)
      ),
    );
  }
}