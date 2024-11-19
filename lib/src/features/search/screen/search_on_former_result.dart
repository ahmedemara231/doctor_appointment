import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/app_widgets/empty_list_widget.dart';
import '../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../../home/screens/doctor_details.dart';
import '../../home/widgets/main_screen_widgets/doctors_card.dart';
import '../bloc/events.dart';
import '../bloc/search_bloc.dart';
import '../bloc/states.dart';

class SearchOnFormerResult extends StatefulWidget {
  final String pattern;
  const SearchOnFormerResult({Key? key,
    required this.pattern,
  }) : super(key: key);

  @override
  State<SearchOnFormerResult> createState() => _SearchOnFormerResultState();
}

class _SearchOnFormerResultState extends State<SearchOnFormerResult> {

  Future<void> _search()async{
    context.read<WholeSearchBloc>().add(ClickNewLetter(widget.pattern));
  }
  @override
  void initState() {
    _search();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: widget.pattern),
      ),
      body: BlocBuilder<WholeSearchBloc, SearchState>(
        builder: (context, state) => Padding(
          padding: context.horizontalSymmetricPadding(12.w),
          child: state.currentState == WholeSearchStates.searchLoading?
          const Center(child: CircularProgressIndicator(),) : state.currentState == WholeSearchStates.searchError?
          ErrorBuilder(
            msg: state.errorMessage!,
            onPressed: () => _search(),
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
                    onTap: () {
                      context.read<WholeSearchBloc>().add(SelectDoctor(state.doctorsInfo![index]));
                      context.normalNewRoute(
                           DoctorDetails<WholeSearchBloc>()
                      );
                    },
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
    );
  }
}
