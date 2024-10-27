import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

import '../helpers/app_widgets/specialities_widget.dart';

class Specialities extends StatelessWidget {
  const Specialities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Doctor Speciality'),
        centerTitle: true,
      ),
      body:  GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: SpecialitiesWidget(
              title: Constants.specialities[index].speciality,
              imageUrl: Constants.specialities[index].image
          ),
        ),
        itemCount: Constants.specialities.length,
      ),
    );
  }
}
