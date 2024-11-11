import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/app_widgets/app_button.dart';
import '../../../core/helpers/data_types/about_doctor.dart';
import '../models/doctor_data.dart';
import '../widgets/doctor_details_widgets/about_widget.dart';
import '../widgets/doctor_details_widgets/base_details.dart';
import '../widgets/doctor_details_widgets/location_widget.dart';
import '../widgets/doctor_details_widgets/rating/rating.dart';
import 'book_appointment/main/main_screen.dart';

class DoctorDetails extends StatefulWidget {
  final DoctorInfo info;
  const DoctorDetails({Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final List<String> titles = ['About', 'Location', 'Reviews'];

  late List<AboutDoctor> aboutDoctorList;

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  void initState() {
    aboutDoctorList = [
      AboutDoctor(
          title: 'About me',
          value:
          '''
General: ${widget.info.description}
Address: ${widget.info.address}
          '''
      ),
      AboutDoctor(title: 'Working Time', value: '${widget.info.startTime} - ${widget.info.endTime}'),
      AboutDoctor(title: 'Phone Number', value: widget.info.phone),
      AboutDoctor(
          title: 'Location',
          value:
          '''
City: ${widget.info.city.name}
Government: ${widget.info.city.governate.name}
          '''
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: MyText(text: widget.info.name),
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
                  info: widget.info,
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
                      LocationWidget(city: widget.info.city.name),
                      Rating(
                        scaffoldKey: _scaffoldKey,
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