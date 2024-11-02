import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final Color? color;
  final TextDecoration? textDecoration;

  const MyText({Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.color,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines?? 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize ,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
