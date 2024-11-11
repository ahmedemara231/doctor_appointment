import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

import '../../constants/app_constants.dart';
import '../base_widgets/text.dart';

class AppLoadingButton extends StatelessWidget {
  const AppLoadingButton({Key? key,
    required this.onPressed,
    required this.title,
    required this.btnController
  }) : super(key: key);
  final void Function()? onPressed;
  final String title;
  final LoadingButtonController btnController;
  @override
  Widget build(BuildContext context) {
    return  LoadingButton(
      // completionCurve: ,
      // completionDuration: ,
      // duration: ,
      errorColor: Colors.red,
      primaryColor: Constants.appColor,
      width: context.setWidth(1),
      successColor: Constants.appColor,
      successIcon: Icons.done,
      iconData: Icons.login,
      onPressed: onPressed,
      controller: btnController,
      child: MyText(text: title),
    );
  }
}
