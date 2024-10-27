import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/doctors_search.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../home/widgets/doctors_card.dart';

class DoctorsBasedSpecialities extends StatefulWidget {
  final int index;

  const DoctorsBasedSpecialities({
    super.key,
    required this.index,
  });

  @override
  State<DoctorsBasedSpecialities> createState() =>
      _DoctorsBasedSpecialitiesState();
}

class _DoctorsBasedSpecialitiesState extends State<DoctorsBasedSpecialities> {
  late TextEditingController controller;
  @override
  void initState() {
    context.read<HomeCubit>().showDoctorsBasedOnSpeciality(widget.index);
    controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: Constants.specialities[widget.index].speciality),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              DoctorsSearch(controller: controller, onChanged: (p0) {},),
              Expanded(
                child: Skeletonizer(
                  enabled: state.currentState == States.doctorsBasedOnSpecializationLoading,
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          DoctorsCard(
                              url: state.doctorsBasedOnSpecialization?[index].photo,
                              doctorName: state.doctorsBasedOnSpecialization?[index].name,
                              speciality: state.doctorsBasedOnSpecialization?[index].specialization.name
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 16.h,
                          ),
                      itemCount: state.doctorsBasedOnSpecialization!.length
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
