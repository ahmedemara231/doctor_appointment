import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/model/remote/api_service/models/doctor_data.dart';
import 'package:doctors_appointment/view/doctor_details/widgets/base_details.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  final DoctorInfo info;
  const DoctorDetails({Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: info.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BaseDetails(
              imageUrl: info.photo,
              name: info.name,
              specialization: info.specialization.name
          )
        ],
      ),
    );
  }
}
