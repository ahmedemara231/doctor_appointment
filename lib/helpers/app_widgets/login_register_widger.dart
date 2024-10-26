import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_button.dart';
import 'package:doctors_appointment/helpers/app_widgets/or_sign_with.dart';
import 'package:doctors_appointment/helpers/app_widgets/other_options.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view/login/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/sign_up/screen.dart';

class LoginRegisterWidget extends StatelessWidget {

  const LoginRegisterWidget({Key? key,
    required this.title,
    required this.secondTitle,
    required this.secondOption,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String secondTitle;
  final String secondOption;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: context.verticalSymmetricPadding(16.h),
          child: AppButton(title: title, onPressed: onPressed),
        ),
        const OrSignWith(),
        Padding(
          padding: context.verticalSymmetricPadding(16.h),
          child: const OtherOptions(),
        ),
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
