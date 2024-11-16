import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../../../core/helpers/app_widgets/app_loading_button.dart';
import 'or_sign_with.dart';

class LoginRegisterWidget extends StatelessWidget {

  const LoginRegisterWidget({Key? key,
    required this.title,
    required this.secondTitle,
    required this.secondOption,
    required this.onPressed,
    required this.btnController
  }) : super(key: key);

  final String title;
  final String secondTitle;
  final String secondOption;
  final void Function() onPressed;

  final LoadingButtonController btnController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: context.verticalSymmetricPadding(16.h),
          child: AppLoadingButton(
            onPressed: onPressed,
            title: title,
            btnController: btnController,
          ),
        ),
        const OrSignWith(),
        // Padding(
        //   padding: context.verticalSymmetricPadding(16.h),
        //   child: const OtherOptions(),
        // ),
        const Text.rich(
          TextSpan(
            text: 'By logging, you agree to our ', // Default style for the first part
            style: TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Terms & Conditions',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              TextSpan(
                text: ' and ',
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(
                text: 'PrivacyPolicy',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(text: secondTitle,),
            InkWell(
                onTap: () {
                  switch(secondOption) {
                    case 'Login':
                      context.removeOldRoute(const Login());
                      break;

                    case 'Sign up':
                      context.normalNewRoute(const SignUp());
                      break;

                    default:
                      break;
                  }
                },
                child: MyText(text: secondOption, color: Constants.appColor,))
          ],
        )
      ],
    );
  }
}
