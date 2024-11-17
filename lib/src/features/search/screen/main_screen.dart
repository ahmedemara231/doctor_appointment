import 'package:doctors_appointment/src/core/helpers/app_widgets/empty_list_widget.dart';
import 'package:doctors_appointment/src/features/home/widgets/recommended_doctors_widgets/sorting.dart';
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
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/data_types/sorting_result.dart';
import '../../home/widgets/main_screen_widgets/doctors_card.dart';

class WholeDoctorsSearch extends StatefulWidget {
  const WholeDoctorsSearch({super.key});

  @override
  State<WholeDoctorsSearch> createState() => _WholeDoctorsSearchState();
}

class _WholeDoctorsSearchState extends State<WholeDoctorsSearch> {
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

  late final GlobalKey<ScaffoldState> scaffoldKey;
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
    scaffoldKey = GlobalKey<ScaffoldState>();
    btnController = LoadingButtonController();
    super.initState();
  }
  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    btnController.stop();
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
            // ValueListenableBuilder(
            //     valueListenable: isSearchBarVisible,
            //     builder: (context, value, child) => SearchAndSorting(
            //       value: value,
            //       scaffoldKey: scaffoldKey,
            //       controller: searchController,
            //       onChanged: (pattern) => context.read<WholeSearchBloc>().add(ClickNewLetter(pattern)),
            //       // sortByWidgets: [
            //       //   SortByWidget(
            //       //       sortingType: 'Specialization',
            //       //       sortingValues: values,
            //       //       onSort: (selectedOption) {},
            //       //       selectedIndex: selectedIndex
            //       //   )
            //       // ],
            //       // onSortBtnPress: () => context.read<HomeCubit>().sortDoctors(result),
            //     )
            // ),
            BlocBuilder<WholeSearchBloc, SearchState>(
              builder: (context, state) => Expanded(
                child: state.currentState == WholeSearchStates.searchLoading?
                const Center(child: CircularProgressIndicator(),) : state.currentState == WholeSearchStates.searchError?
                ErrorBuilder(
                  msg: state.errorMessage!,
                  onPressed: () {},
                ) : state.doctorsInfo!.isEmpty? const EmptyListWidget() :
                ListView.builder(
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
