import 'package:flutter/cupertino.dart';

class RegisterWidgetInputs{
  final String hintText;
  final bool obscureText;
  final TextEditingController cont;
  final String? Function(String?) validation;

  RegisterWidgetInputs({
    required this.hintText,
    required this.obscureText,
    required this.cont,
    required this.validation,
  });
}