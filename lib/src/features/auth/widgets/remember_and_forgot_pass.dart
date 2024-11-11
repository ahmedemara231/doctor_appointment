import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/base_widgets/text.dart';

class RememberAndForgotPass extends StatelessWidget {
  const RememberAndForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {},),
        const MyText(text : 'remember Me'),
        const Spacer(),
        MyText(
            text : 'Forgot Password?',
            color: Constants.appColor, fontWeight: FontWeight.bold
        )
      ],
    );
  }
}
