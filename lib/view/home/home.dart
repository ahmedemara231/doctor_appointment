import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/specialities_widget.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/view/doctors_based_specialities/screen.dart';
import 'package:doctors_appointment/view/error_builder/screen.dart';
import 'package:doctors_appointment/view/home/widgets/card.dart';
import 'package:doctors_appointment/view/home/widgets/doctors_card.dart';
import 'package:doctors_appointment/view/recommended_doctors/screen.dart';
import 'package:doctors_appointment/view/specialities/screen.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../helpers/base_widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomeData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'Hi, ${CacheHelper.getInstance().getUserData()?[0]}', fontWeight: FontWeight.w500,),
                MyText(text: 'How are you today?', color: Colors.grey, fontSize: 16.sp,),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none)
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: context.horizontalSymmetricPadding(12.w),
              child: Column(
                children: [
                  const HomeCard(),
                  Row(
                    children: [
                      MyText(text: 'Doctor Speciality', fontSize: 18.sp, fontWeight: FontWeight.w500,),
                      const Spacer(),
                      TextButton(
                          onPressed: (){
                            context.normalNewRoute(const Specialities());
                          },
                          child: MyText(text: 'See All', color: Colors.blue,)
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          Constants.specialities.sublist(0,4).length,
                              (index) => InkWell(
                                onTap: () {
                                  context.normalNewRoute(
                                      DoctorsBasedSpecialities(index: index)
                                  );
                                },
                                child: SpecialitiesWidget(
                                    title: Constants.specialities[index].speciality,
                                    imageUrl: Constants.specialities[index].image
                                ),
                              )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      MyText(text: 'Recommendation Doctor', fontSize: 18.sp, fontWeight: FontWeight.w500,),
                      const Spacer(),
                      TextButton(
                          onPressed: (){
                            context.normalNewRoute(RecommendedDoctors());
                          },
                          child: MyText(text: 'See All', color: Colors.blue,)
                      )
                    ],
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state.currentState == States.homeDataLoading,
                        child: state.currentState == States.homeDataError?
                        ErrorBuilder(msg: 'Try Again Later', onPressed: () => context.read<HomeCubit>().getHomeData(),) :
                        Column(
                          children:
                          List.generate(state.homeData!.length, (index) => Padding(
                            padding: context.verticalSymmetricPadding(12.h),
                            child: DoctorsCard(
                                url: state.homeData![index].allInfo[0].photo,
                                doctorName: state.homeData![index].allInfo[0].name,
                                speciality: state.homeData![index].allInfo[0].specialization.name
                            ),
                          ))
                        )
                      );
                    },
                  )
                ],
              ),
            ),
          )
      );
  }
}