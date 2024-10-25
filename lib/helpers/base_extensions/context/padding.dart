import 'package:flutter/cupertino.dart';

extension AppPadding on BuildContext{
  EdgeInsetsGeometry allPadding(double value){
    return EdgeInsets.all(value);
  }

  EdgeInsetsGeometry horizontalSymmetricPadding(double value){
    return EdgeInsets.symmetric(horizontal: value);
  }

  EdgeInsetsGeometry verticalSymmetricPadding(double value){
    return EdgeInsets.symmetric(vertical: value);
  }

  EdgeInsetsGeometry onlyTopPadding(double value){
    return EdgeInsets.only(top: value);
  }

  EdgeInsetsGeometry onlyBottomPadding(double value){
    return EdgeInsets.only(bottom: value);
  }

  EdgeInsetsGeometry onlyRightPadding(double value){
    return EdgeInsets.only(right: value);
  }

  EdgeInsetsGeometry onlyLeftPadding(double value){
    return EdgeInsets.only(left: value);
  }
}