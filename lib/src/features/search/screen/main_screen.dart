import 'package:doctors_appointment/src/core/helpers/app_widgets/empty_list_widget.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/error_builder/screen.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/src/features/home/screens/doctor_details.dart';
import 'package:doctors_appointment/src/features/search/bloc/whole_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/helpers/app_widgets/doctors_search.dart';
import '../../home/widgets/main_screen_widgets/doctors_card.dart';

class WholeDoctorsSearch extends StatefulWidget {
  const WholeDoctorsSearch({super.key});

  @override
  State<WholeDoctorsSearch> createState() => _WholeDoctorsSearchState();
}

class _WholeDoctorsSearchState extends State<WholeDoctorsSearch> {

  late TextEditingController searchController;

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
    searchController = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(text: 'Search'),
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
                    height: isSearchBarVisible.value ? 90.h : 0,
                    child: isSearchBarVisible.value ?
                    DoctorsSearch(
                      controller: searchController,
                      onChanged: (pattern) => context.read<WholeSearchBloc>()
                          .add(ClickNewLetter(pattern)
                      )
                    ) : const SizedBox.shrink()
                )
            ),
            BlocBuilder<WholeSearchBloc, SearchState>(
              builder: (context, state) => Expanded(
                child: state.currentState == WholeSearchStates.searchLoading?
                const Center(child: CircularProgressIndicator(),) : state.currentState == WholeSearchStates.searchError?
                ErrorBuilder(
                  msg: state.errorMessage!,
                  onPressed: () {},
                ) : state.doctorsInfo!.isEmpty? const EmptyListWidget() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: context.verticalSymmetricPadding(12.h),
                      child: MyText(
                        text: '${state.doctorsInfo!.length} Result Found',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.doctorsInfo?.length?? 5,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => context.normalNewRoute(
                              DoctorDetails(info: state.doctorsInfo![index]
                              )
                          ),
                          child: DoctorsCard(
                              url: state.doctorsInfo![index].photo,
                              doctorName: state.doctorsInfo![index].name,
                              speciality: state.doctorsInfo![index].specialization.name
                          ),
                        ),),
                    ),
                  ],
                ),
              ),
            ),

            // BlocBuilder<WholeSearchBloc, SearchState>(
            //   builder: (context, state) => Expanded(
            //     child: Skeletonizer(
            //       enabled: state.currentState == WholeSearchStates.searchLoading,
            //       child: state.currentState == WholeSearchStates.searchError?
            //       ErrorBuilder(
            //         msg: state.errorMessage!,
            //         onPressed: () {},
            //       ) :
            //       ListView.builder(
            //         controller: _scrollController,
            //         itemCount: state.doctorsInfo?.length,
            //         itemBuilder: (context, index) => InkWell(
            //           onTap: () => context.normalNewRoute(
            //               DoctorDetails(info: state.doctorsInfo![index]
            //               )
            //           ),
            //           child: DoctorsCard(
            //               url: state.doctorsInfo![index].photo,
            //               doctorName: state.doctorsInfo![index].name,
            //               speciality: state.doctorsInfo![index].specialization.name
            //           ),
            //         ),),
            //     )
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
