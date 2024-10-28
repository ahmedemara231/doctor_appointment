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
  late int activeStep;
  List<String> titles = ['Date & Time', 'Payment', 'Summary'];

  @override
  void initState() {
    activeStep = widget.newStep;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  EasyStepper(
      activeStep: activeStep,
      stepShape: StepShape.circle,
      borderThickness: 1,
      padding: context.allPadding(10),
      stepRadius: 28,
      finishedStepBorderColor: Colors.white,
      finishedStepTextColor: Colors.white,
      finishedStepBackgroundColor: Constants.appColor,
      unreachedStepBackgroundColor: Colors.grey.withOpacity(.3),
      unreachedStepIconColor: Colors.red,
      showLoadingAnimation: true,
      steps: List.generate(titles.length, (index) => EasyStep(
        customStep: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Opacity(
            opacity: activeStep >= index ? 1 : 0.3,
            child: MyText(text: (index+1).toString(), color: Colors.white,),
          ),
        ),
        customTitle: Center(
          child: MyText(
            text: titles[index],
          ),
        ),
      ),),
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}
