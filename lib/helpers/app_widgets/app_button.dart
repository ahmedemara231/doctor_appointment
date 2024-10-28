import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:flutter/material.dart';
import '../base_widgets/text.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.appColor,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
          width: context.setWidth(1),
          child: Center(
              child: FittedBox(
                  child: MyText(
                    text: title,
                    color: Colors.white,
                  )
              )
          )
      ),
    );
  }
}
