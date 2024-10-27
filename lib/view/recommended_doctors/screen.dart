import 'package:doctors_appointment/helpers/app_widgets/app_loading_button.dart';
import 'package:doctors_appointment/helpers/app_widgets/doctors_search.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/mediaQuery.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/divider.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/helpers/base_widgets/text_field.dart';
import 'package:doctors_appointment/helpers/data_types/sorting_result.dart';
import 'package:doctors_appointment/view/recommended_doctors/widgets/sort_by.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import '../home/widgets/doctors_card.dart';

class RecommendedDoctors extends StatefulWidget {
  RecommendedDoctors({super.key});

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late LoadingButtonController btnController;
  late TextEditingController searchController;

  late SortingResult result = SortingResult();

  List<String> values = const <String>['All', 'General', 'Cardiology', 'Dermatology', 'Gastroenterology', 'Orthopedics', 'Urology', 'Neurology',];

  List<String> ratingValues = const <String>['1', '2', '3', '4', '5', 'All'];

  @override
  void initState() {
    context.read<HomeCubit>().begin();
    searchController = TextEditingController();
    btnController = LoadingButtonController();
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    btnController.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      child: DoctorsSearch(
                          controller: searchController,
                          onChanged: (p0) {},
                      )
                  ),
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.showBottomSheet((context) => SizedBox(
                          height: context.setHeight(2),
                          child: Padding(
                            padding: context.horizontalSymmetricPadding(12.w),
                            child: Column(
                              children: [
                                SizedBox(height: 16.h),
                                MyText(text: 'Sort By', fontSize:  20.sp, fontWeight: FontWeight.w500,),
                                Padding(
                                  padding: context.verticalSymmetricPadding(16.h),
                                  child: const MyDivider(),
                                ),
                                Expanded(
                                    child: SortByWidget(
                                      sortingType: 'Speciality',
                                      sortingValues: values,
                                      onSort: (selectedOption) => result.speciality = selectedOption,
                                      selectedIndex: values.indexOf(result.speciality?? 'All'),
                                    )
                                ),
                                Expanded(
                                    child: SortByWidget(
                                      sortingType: 'Rating',
                                      sortingValues: ratingValues,
                                      onSort: (selectedOption) => result.rating = selectedOption,
                                      selectedIndex: ratingValues.indexOf(result.rating?? '1'),
                                    )
                                ),
                                AppLoadingButton(
                                    onPressed: ()async{
                                      context.read<HomeCubit>().sortDoctors(result);
                                      btnController.success();
                                      await Future.delayed(const Duration(seconds: 2));
                                      Navigator.pop(context);
                                    },
                                    title: 'Sort',
                                    btnController: btnController
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      icon: const Icon(Icons.sort)
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) => Column(
                  children: List.generate(
                    state.filteredDoctors!.length,
                        (index) => Padding(
                          padding: context.verticalSymmetricPadding(12.h),
                          child: DoctorsCard(
                              url: state.filteredDoctors![index].photo,
                              doctorName: state.filteredDoctors![index].name,
                              speciality: state.filteredDoctors![index].specialization.name
                          ),
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