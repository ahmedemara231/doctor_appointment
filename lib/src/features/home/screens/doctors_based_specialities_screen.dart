import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/helpers/app_widgets/doctors_search.dart';
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
  bool _isSearchBarVisible = true;
  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isSearchBarVisible) {
        setState(() {
          _isSearchBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isSearchBarVisible) {
        setState(() {
          _isSearchBarVisible = true;
        });
      }
    }
  }
  Future<void> _requestDoctorsBasedOnSpecialization() async {
    context.read<HomeCubit>().showDoctorsBasedOnSpeciality(widget.index);
  }
  @override
  void initState() {
    _requestDoctorsBasedOnSpecialization();
    controller = TextEditingController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }
  @override
  void dispose() {
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isSearchBarVisible? 90.h : 0,
                  child: _isSearchBarVisible? Padding(
                    padding: context.verticalSymmetricPadding(12.h),
                    child: DoctorsSearch(controller: controller, onChanged: (p0) {},),
                  ) : const SizedBox.shrink()
                ),
                Expanded(
                  child: Skeletonizer(
                    enabled: state.currentState == States.doctorsBasedOnSpecializationLoading,
                    child: state.currentState == States.doctorsBasedOnSpecializationError?
                    ErrorBuilder(
                      msg: state.errorMsg.toString(),
                      onPressed: () => _requestDoctorsBasedOnSpecialization,
                    ) :
                    ListView.separated(
                      controller: _scrollController,
                        itemBuilder: (context, index) =>
                            InkWell(
                              onTap: () {
                                context.read<HomeCubit>().selectDoctor(
                                    selectedDoctor: state.doctorsBasedOnSpecialization?[index]
                                );

                                context.normalNewRoute(
                                    DoctorDetails(info: state.doctorsBasedOnSpecialization?[index])
                                );
                              },
                              child: DoctorsCard(
                                  url: state.doctorsBasedOnSpecialization?[index].photo,
                                  doctorName: state.doctorsBasedOnSpecialization?[index].name,
                                  speciality: state.doctorsBasedOnSpecialization?[index].specialization.name
                              ),
                            ),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 16.h,
                            ),
                        itemCount: state.doctorsBasedOnSpecialization!.length
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