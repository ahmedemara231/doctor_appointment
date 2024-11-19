import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/src/core/helpers/data_types/appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/helpers/app_widgets/app_button.dart';
import '../../../../../core/helpers/base_widgets/text.dart';
import '../../../blocs/home/cubit.dart';
import '../../../blocs/home/state.dart';
import '../../../blocs/payment/cubit.dart';

class Summary extends StatelessWidget{
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyText(text: 'Booking Information', fontWeight: FontWeight.w500),
              ListTile(
                leading: SvgPicture.asset(Assets.iconsDateTimeResult),
                title: const MyText(
                  text: 'Date & Time', fontWeight: FontWeight.w500,),
                subtitle: MyText(text: '${state.appointmentDate} ${state.appointmentTime}'),
              ),
              ListTile(
                leading: SvgPicture.asset(Assets.iconsApoointmentType),
                title: const MyText(text: 'Appointment Type', fontWeight: FontWeight.w500,),
                subtitle: MyText(text: state.appointmentType!),
              ),
              const Spacer(),
              AppButton(
                  title: 'Pay',
                  onPressed: () async {
                    UserAppointmentDetails details = UserAppointmentDetails(
                        appointmentDate: state.appointmentDate!,
                        appointmentTime: state.appointmentTime!,
                        appointmentType: state.appointmentType!
                    );
                    context.read<PaymentCubit>().pay(
                        context,
                        amount: 100,
                        details: details
                    );
                  }
              ),
            ],
          );
        },
      ),
    );
  }
}