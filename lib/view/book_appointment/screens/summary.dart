import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../helpers/base_widgets/text.dart';
import '../interface.dart';

class Summary extends StatelessWidget implements CheckingValue {
  Summary({Key? key}) : super(key: key);

  @override
  var value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: 'Booking Information', fontWeight: FontWeight.w500),
              ListTile(
                leading: SvgPicture.asset(Assets.iconsDateTimeResult),
                title: MyText(
                  text: 'Date & Time', fontWeight: FontWeight.w500,),
                subtitle: MyText(text: '${state.appointmentDate} ${state.appointmentTime}'),
              ),
              ListTile(
                leading: SvgPicture.asset(Assets.iconsApoointmentType),
                title: MyText(text: 'Appointment Type', fontWeight: FontWeight.w500,),
                subtitle: MyText(text: state.appointmentType!),
              ),
            ],
          );
        },
      ),
    );
  }
}