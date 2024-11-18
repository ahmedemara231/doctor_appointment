import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/app_widgets/specialities_widget.dart';
import '../../../core/helpers/base_widgets/text.dart';
import 'doctors_based_specialities_screen.dart';

class Specialities extends StatelessWidget {
  const Specialities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(text: 'Doctor Speciality'),
        centerTitle: true,
      ),
      body:  GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            context.normalNewRoute(
                DoctorsBasedSpecialities(
                  index: index,
                )
            );
          },
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
