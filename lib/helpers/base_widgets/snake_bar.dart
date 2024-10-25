import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
class MySnackBar
{
  static void showSnackBar({
    required context,
    required String message,
    Color? color
  })
  {
    SnackBar snackBar = SnackBar(
      backgroundColor: color?? Colors.grey,
      content: MyText(
        text: message,
        fontSize: 20,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}