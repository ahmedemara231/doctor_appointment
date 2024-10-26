import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/helpers/base_widgets/text_field.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/widgets/doctors_card.dart';

class RecommendedDoctors extends StatelessWidget {

  // final List recommendedDoctorsData;
  // const RecommendedDoctors({super.key,
  //   required this.recommendedDoctorsData,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Recommendation Doctor', fontWeight: FontWeight.w500,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.horizontalSymmetricPadding(12.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TFF(
                        obscureText: false,
                        controller: TextEditingController(),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey
                            )
                        ),
                      )
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
                ],
              ),
              SizedBox(height: 16.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) => Column(
                  children: List.generate(
                    state.recommendedDoctors!.length,
                        (index) => DoctorsCard(
                        url: state.recommendedDoctors![index].photo,
                        doctorName: state.recommendedDoctors![index].name,
                        speciality: state.recommendedDoctors![index].name
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
