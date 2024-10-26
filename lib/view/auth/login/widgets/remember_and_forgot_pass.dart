import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

class RememberAndForgotPass extends StatelessWidget {
  const RememberAndForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {},),
        MyText(text : 'remember Me'),
        const Spacer(),
        MyText(
            text : 'Forgot Password?',
            color: Constants.appColor, fontWeight: FontWeight.bold
        )
      ],
    );
  }
}
