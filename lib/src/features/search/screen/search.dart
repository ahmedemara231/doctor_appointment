import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text_field.dart';
import 'package:doctors_appointment/src/features/home/blocs/home/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../core/helpers/app_widgets/empty_list_widget.dart';
import '../../../core/helpers/base_widgets/error_builder/screen.dart';
import '../../../core/helpers/base_widgets/text.dart';
import '../../home/screens/doctor_details.dart';
import '../../home/widgets/main_screen_widgets/doctors_card.dart';
import '../bloc/events.dart';
import '../bloc/search_bloc.dart';
import '../bloc/states.dart';


class AppSearch extends StatefulWidget {
  const AppSearch({super.key});

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TFF(
          obscureText: false,
          controller: _searchController,
          border: InputBorder.none,
          autoValidateMode: AutovalidateMode.disabled,
          onChanged: (query) => context.read<WholeSearchBloc>().add(
              ClickNewLetter(query)
          ),
          onFieldSubmitted: (query) {
            context.read<WholeSearchBloc>().add(
                ClickNewLetter(query)
            );
            context.read<WholeSearchBloc>().add(
                AddSearchHistory(query)
            );
          },
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              _searchController.clear();
            },
          ),
        ],
      ),
      body: BlocBuilder<WholeSearchBloc, SearchState>(
        builder: (context, state) => state.currentState == WholeSearchStates.searchLoading?
        const Center(child: CircularProgressIndicator()) : state.currentState == WholeSearchStates.searchError?
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
                itemCount: state.doctorsInfo?.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.read<WholeSearchBloc>().add(SelectDoctor(state.doctorsInfo?[index]));
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
      )
    );
  }
}