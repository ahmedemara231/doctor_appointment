import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/features/home/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import '../../../core/helpers/app_widgets/doctors_search.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../../../core/helpers/data_types/sorting_result.dart';
import '../blocs/home/cubit.dart';
import '../blocs/home/state.dart';
import '../widgets/main_screen_widgets/doctors_card.dart';

class RecommendedDoctors extends StatefulWidget {
  const RecommendedDoctors({super.key});

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late LoadingButtonController btnController;
  late TextEditingController searchController;

  SortingResult result = SortingResult();

  List<String> values = const <String>[
    'All',
    'General',
    'Cardiology',
    'Dermatology',
    'Gastroenterology',
    'Orthopedics',
    'Urology',
    'Neurology',
  ];

  List<String> ratingValues = const <String>['1', '2', '3', '4', '5', 'All'];

  late ScrollController _scrollController;
  ValueNotifier<bool> isSearchBarVisible = ValueNotifier(true);

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          if(isSearchBarVisible.value){
            isSearchBarVisible.value = false;
          }
    } else {
      if(!isSearchBarVisible.value){
            isSearchBarVisible.value = true;
      }
    }
  }
  @override
  void initState() {
    context.read<HomeCubit>().begin();
    searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    btnController = LoadingButtonController();
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    btnController.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const MyText(text: 'Recommendation Doctor', fontWeight: FontWeight.w500,),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: isSearchBarVisible,
              builder: (context, value, child) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: value ? 90.h : 0,
                  child: value
                      ? DoctorsSearch(
                    controller: searchController,
                    onChanged: (p0) {},
                  )
                      : const SizedBox.shrink()),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Expanded(
                // height: 400,
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.read<HomeCubit>().selectDoctor(
                          selectedDoctor: state.filteredDoctors![index]
                      );

                      context.normalNewRoute(
                          DoctorDetails(info: state.filteredDoctors![index])
                      );
                    },
                    child: DoctorsCard(
                        url: state.filteredDoctors![index].photo,
                        doctorName: state.filteredDoctors![index].name,
                        speciality: state.filteredDoctors![index].specialization.name
                    ),
                  ),
                  itemCount: state.filteredDoctors!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}