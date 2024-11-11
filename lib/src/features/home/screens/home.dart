import 'dart:developer';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/translations/locale_keys.g.dart';
import 'package:doctors_appointment/src/features/home/screens/doctor_details.dart';
import 'package:doctors_appointment/src/features/home/screens/doctors_based_specialities_screen.dart';
import 'package:doctors_appointment/src/features/home/screens/recommended_doctors_screen.dart';
import 'package:doctors_appointment/src/features/home/screens/specialities_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data_source/local/shared.dart';
import '../../../core/helpers/app_widgets/specialities_widget.dart';
import '../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../blocs/home/cubit.dart';
import '../blocs/home/state.dart';
import '../widgets/main_screen_widgets/card.dart';
import '../widgets/main_screen_widgets/doctors_card.dart';

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
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }
  bool isEn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: '${LocaleKeys.welcome.tr()}  ${CacheHelper.getInstance().getUserData()?[0]}',
                  fontWeight: FontWeight.w500,
                ),
                MyText(
                  text: LocaleKeys.howAreYouToday.tr(),
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    if(isEn){
                      context.setLocale(const Locale('ar', 'SA'));
                      isEn = false;
                    }else{
                      context.setLocale(const Locale('en', 'US'));
                      isEn = true;
                    }
                    log(context.locale.languageCode);
                  },
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
                      MyText(text: LocaleKeys.doctorSpeciality.tr(), fontSize: 18.sp, fontWeight: FontWeight.w500,),
                      const Spacer(),
                      TextButton(
                          onPressed: (){
                            context.normalNewRoute(const Specialities());
                          },
                          child: MyText(
                            text: LocaleKeys.seeAll.tr(),
                            color: Colors.blue,
                          )
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
                                    title: Constants.specialities[index].speciality.tr(),
                                    imageUrl: Constants.specialities[index].image
                                ),
                              )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      MyText(
                        text: LocaleKeys.recommendationDoctor.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: (){
                            context.normalNewRoute(const RecommendedDoctors());
                          },
                          child: MyText(text: LocaleKeys.seeAll.tr(), color: Colors.blue,)
                      )
                    ],
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state.currentState == States.homeDataLoading,
                        child: state.currentState == States.homeDataError?
                        SizedBox(
                          height: 200.h,
                            child: ErrorBuilder(
                              msg: state.errorMsg!,
                              onPressed: () => context.read<HomeCubit>().getHomeData(),
                            )
                        ):
                        Column(
                          children: List.generate(state.homeData!.length, (index) => Padding(
                            padding: context.verticalSymmetricPadding(12.h),
                            child: InkWell(
                              onTap: () {
                                context.read<HomeCubit>().selectDoctor(selectedDoctor: state.homeData![index].allInfo[0]);
                                context.normalNewRoute(
                                    DoctorDetails(info:  state.homeData![index].allInfo[0])
                                );
                              },
                              child: DoctorsCard(
                                  url: state.homeData![index].allInfo[0].photo,
                                  doctorName: state.homeData![index].allInfo[0].name,
                                  speciality: state.homeData![index].allInfo[0].specialization.name
                              ),
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