import 'package:flutter/material.dart';

import '../../../core/helpers/base_widgets/text_field.dart';
class AuthTextFields extends StatefulWidget {

  final String hintText;
  bool obscureText;
  final TextEditingController cont;
  final String? Function(String?) validation;
  Iterable<String>? autofillHints;

  AuthTextFields({Key? key,
    required this.hintText,
    required this.obscureText,
    required this.cont,
    required this.validation,
    this.autofillHints
  }) : super(key: key);

  @override
  State<AuthTextFields> createState() => _AuthTextFieldsState();
}

class _AuthTextFieldsState extends State<AuthTextFields> {
  @override
  Widget build(BuildContext context) {
    return TFF(
      autofillHints: widget.autofillHints,
      obscureText: widget.obscureText,
      controller: widget.cont,
      hintText: widget.hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      validator: widget.validation,
      suffixIcon: widget.hintText == 'Password' || widget.hintText == 'Confirm Password'?
      IconButton(
          onPressed: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
          icon: Icon(
              widget.obscureText?
              Icons.visibility_off : Icons.visibility
          )) : null,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(16)
      ),
    );
  }
}