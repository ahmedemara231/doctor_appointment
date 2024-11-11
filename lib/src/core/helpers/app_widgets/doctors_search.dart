import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base_widgets/text_field.dart';

class DoctorsSearch extends StatelessWidget {
  const DoctorsSearch({Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TFF(
      obscureText: false,
      controller: controller,
      onChanged: onChanged,
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      hintText: 'Search',
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.grey
          )
      ),
    );
  }
}