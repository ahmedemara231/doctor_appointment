import 'package:doctors_appointment/src/core/helpers/app_widgets/empty_list_widget.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/app_widgets/search_sorting.dart';
import '../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../blocs/home/cubit.dart';
import '../blocs/home/state.dart';
import '../widgets/main_screen_widgets/doctors_card.dart';
import 'doctor_details.dart';

class DoctorsBasedSpecialities extends StatefulWidget {
  final int index;

  const DoctorsBasedSpecialities({
    super.key,
    required this.index,
  });

  @override
  State<DoctorsBasedSpecialities> createState() =>
      _DoctorsBasedSpecialitiesState();
}

class _DoctorsBasedSpecialitiesState extends State<DoctorsBasedSpecialities> {
  late TextEditingController controller;
  late ScrollController _scrollController;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  ValueNotifier<bool> isSearchBarVisible = ValueNotifier(true);
  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (isSearchBarVisible.value) {
          isSearchBarVisible.value = false;
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!isSearchBarVisible.value) {
          isSearchBarVisible.value = true;
      }
    }
  }
  Future<void> _requestDoctorsBasedOnSpecialization() async {
    context.read<HomeCubit>().showDoctorsBasedOnSpeciality(widget.index);
  }
  @override
  void initState() {
    _requestDoctorsBasedOnSpecialization();
    scaffoldKey = GlobalKey<ScaffoldState>();
    controller = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }
  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    controller.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: Constants.specialities[widget.index].speciality),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: context.horizontalSymmetricPadding(12.w),
            child: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: isSearchBarVisible,
                    builder: (context, value, child) => SearchAndSorting(
                        scaffoldKey: scaffoldKey,
                        controller: controller,
                        value: value,
                        onChanged: (p0) => context.read<HomeCubit>().search(
                            pattern: p0,
                            isByRecommended: false
                        )
                    )
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: state.currentState == States.doctorsBasedOnSpecializationLoading,
                    child: state.currentState == States.doctorsBasedOnSpecializationError?
                    ErrorBuilder(
                      msg: state.errorMsg.toString(),
                      onPressed: () => _requestDoctorsBasedOnSpecialization,
                    ) : state.filteredDoctors!.isEmpty?
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
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 16.h,
                            ),
                        itemCount: state.filteredDoctors!.length
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}