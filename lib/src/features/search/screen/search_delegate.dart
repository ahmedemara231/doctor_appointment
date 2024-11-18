import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/app_widgets/empty_list_widget.dart';
import '../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../../home/screens/doctor_details.dart';
import '../../home/widgets/main_screen_widgets/doctors_card.dart';
import '../bloc/whole_search_bloc.dart';

class AppSearch extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<WholeSearchBloc>().add(AddSearchHistory(query));
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<WholeSearchBloc>().add(ClickNewLetter(query));

    return  BlocBuilder<WholeSearchBloc, SearchState>(
      builder: (context, state) => state.currentState == WholeSearchStates.searchLoading?
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
    );

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

  }
}