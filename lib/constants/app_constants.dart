import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jiffy/jiffy.dart';

import '../generated/assets.dart';
import '../helpers/data_types/spec.dart';

class Constants
{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static var appColor = HexColor('#247CFF');

  //date time
  static String dataTime = Jiffy().yMMMd;


  // regExp
  static String emailRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["r"a-zA-Z]+";
  static String phoneRegExp = r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]'r'{4,6}$)';

  // specialities
  static List<Speciality> specialities = [
      Speciality(
          image: Assets.imagesGeneral,
          speciality: 'General'
      ),
      Speciality(
          image: Assets.imagesNeurologic,
          speciality: 'Neurologic'
      ),
      Speciality(
          image: Assets.imagesPediatric,
          speciality: 'Pediatric'
      ),
      Speciality(
          image: Assets.imagesRadiology,
          speciality: 'Radiology'
      ),
    ];

  // other
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.black;
  }
}