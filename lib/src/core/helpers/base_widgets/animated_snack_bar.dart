import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';

class AppSnakeBar{
  static show(BuildContext context,{required String title, AnimatedSnackBarType? type}){
    AnimatedSnackBar.material(
        title,
        duration: const Duration(seconds: 3),
        type: type?? AnimatedSnackBarType.info,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom
    ).show(context);
  }
}