import 'package:doctors_appointment/src/core/helpers/app_widgets/empty_list_widget.dart';
import 'package:doctors_appointment/src/features/home/widgets/recommended_doctors_widgets/sorting.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/features/home/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_widgets/doctors_search.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../blocs/home/cubit.dart';
import '../blocs/home/state.dart';
import '../widgets/main_screen_widgets/doctors_card.dart';

class RecommendedDoctors extends StatefulWidget {
  const RecommendedDoctors({super.key});

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  late TextEditingController searchController;

  late final GlobalKey<ScaffoldState> _scaffoldKey;

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
    context.read<HomeCubit>().getRecommendedDoctors();
    searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }
  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const MyText(text: 'Recommended Doctor', fontWeight: FontWeight.w500,),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.horizontalSymmetricPadding(12.w),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: isSearchBarVisible,
              builder: (context, value, child) => Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: isSearchBarVisible.value ? 90.h : 0,
                        child: isSearchBarVisible.value ?
                        DoctorsSearch(
                            controller: searchController,
                            onChanged: (p0) => context.read<HomeCubit>().search(
                                pattern: p0,
                                isByRecommended: true
                            ),
                        ) : const SizedBox.shrink()
                    ),
                  ),
                  IconButton(
                      onPressed: () => _scaffoldKey.currentState!.showBottomSheet(
                              (context) => const Sorting(isRecommended: true)
                      ),
                      icon: const Icon(Icons.sort)
                  )
                ],
              )
            ),
            SizedBox(height: 16.h),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Expanded(
                child: state.filteredDoctors!.isEmpty?
                const EmptyListWidget() :
                ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => context.normalNewRoute(
                        DoctorDetails(info: state.filteredDoctors![index])
                    ),
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