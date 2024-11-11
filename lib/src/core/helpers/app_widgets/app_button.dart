import 'package:doctors_appointment/src/core/helpers/base_extensions/context/mediaQuery.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../base_widgets/text.dart';

class AppButton extends StatelessWidget {

  const AppButton({Key? key,
    required this.title,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Color? color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color?? Constants.appColor,
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
