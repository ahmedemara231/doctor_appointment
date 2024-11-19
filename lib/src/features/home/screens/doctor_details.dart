import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_widgets/app_button.dart';
import '../../../core/helpers/data_types/about_doctor.dart';
import '../models/doctor_data.dart';
import '../widgets/doctor_details_widgets/about_widget.dart';
import '../widgets/doctor_details_widgets/base_details.dart';
import '../widgets/doctor_details_widgets/location_widget.dart';
import '../widgets/doctor_details_widgets/rating/rating.dart';
import 'book_appointment/main/main_screen.dart';

class DoctorDetails<T extends BlocBase> extends StatelessWidget{
  DoctorDetails({Key? key}) : super(key: key);

  final List<String> titles = ['About', 'Location', 'Reviews'];
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  late final List<AboutDoctor> aboutDoctorList;

  @override
  Widget build(BuildContext context) {
    final DoctorInfo info = context.read<T>().state.selectedDoctor!;
    aboutDoctorList = [
      AboutDoctor(
          title: 'About me',
          value:
          '''
General: ${info.description}
Address: ${info.address}
          '''
      ),
      AboutDoctor(title: 'Working Time', value: '${info.startTime} - ${info.endTime}'),
      AboutDoctor(title: 'Phone Number', value: info.phone),
      AboutDoctor(
          title: 'Location',
          value:
          '''
City: ${info.city.name}
Government: ${info.city.governate.name}
          '''
      ),
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: MyText(text: info.name),
        centerTitle: true,
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: titles.length,
        child: Padding(
          padding: context.horizontalSymmetricPadding(12.w),
          child: Column(
            children: [
              BaseDetails(
                info: info,
              ),
              TabBar(
                  tabs: List.generate(
                    titles.length,
                        (index) => Tab(
                      text: titles[index],
                    ),
                  )
              ),
              Expanded(
                child: Padding(
                  padding: context.verticalSymmetricPadding(16.h),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AboutWidget(values: aboutDoctorList),
                      LocationWidget(city: info.city.name),
                      Rating(
                        scaffoldKey: _scaffoldKey,
                        info: info,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: context.verticalSymmetricPadding(12.h),
                child: AppButton(
                    title: 'Make An Appointment',
                    onPressed: () => context.normalNewRoute(
                        const MakeAppointment()
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}