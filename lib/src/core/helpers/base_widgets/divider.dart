import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {

  final double? height;
  const MyDivider({super.key,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      height: height?? 1.5,
    );
  }
}
