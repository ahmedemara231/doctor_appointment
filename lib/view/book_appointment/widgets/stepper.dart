import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class MyStepper extends StatefulWidget {
  const MyStepper({Key? key,
    required this.newStep,
  }) : super(key: key);

  final int newStep;
  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  List<String> titles = ['Date & Time', 'Payment', 'Summary'];

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: widget.newStep,
      stepShape: StepShape.circle,
      borderThickness: 1,
      activeStepBorderType: BorderType.normal,
      unreachedStepBorderType: BorderType.normal,
      finishedStepBorderType: BorderType.normal,
      stepRadius: 28,
      activeStepBackgroundColor: Constants.appColor,
      lineStyle: const LineStyle(lineType: LineType.normal),
      finishedStepBorderColor: Colors.white,
      finishedStepTextColor: Colors.white,
      finishedStepBackgroundColor: Colors.green,
      unreachedStepBackgroundColor: Colors.grey.withOpacity(.3),
      unreachedStepIconColor: Colors.red,
      showLoadingAnimation: true,
      steps: List.generate(titles.length, (index) => EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: widget.newStep >= index ? 1 : 0.3,
            child: MyText(text: (index+1).toString(), color: Colors.white,),
          ),
        ),
        customTitle: Center(
          child: MyText(
            text: titles[index],
          ),
        ),
      ),),
    );
  }
}
