import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/view/error_builder/screen.dart';
import 'package:doctors_appointment/view/home/widgets/card.dart';
import 'package:doctors_appointment/view/home/widgets/doctors_card.dart';
import 'package:doctors_appointment/view/recommended_doctors/screen.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../helpers/base_widgets/text.dart';
import '../../helpers/data_types/spec.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Speciality> specialities = [
    Speciality(
        image: Assets.imagesGeneral,
        speciality: 'General'
    ),
    Speciality(
        image: Assets.imagesNeurologic,
        speciality: 'Neurologic'
    ),
    Speciality(
        image: Assets.imagesPediatric,
        speciality: 'Pediatric'
    ),
    Speciality(
        image: Assets.imagesRadiology,
        speciality: 'Radiology'
    ),
  ];

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
                          onPressed: (){},
                          child: MyText(text: 'See All', color: Colors.blue,)
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          specialities.length,
                              (index) => Column(
                            children: [
                              CircleAvatar(
                                radius: 30.sp,
                                backgroundColor: Colors.grey[200],
                                child: Image.asset(specialities[index].image),
                              ),
                              const SizedBox(height: 5),
                              MyText(
                                text: specialities[index].speciality,
                                fontSize: 12.sp,
                              )
                            ],
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