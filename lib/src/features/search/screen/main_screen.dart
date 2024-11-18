import 'package:doctors_appointment/src/core/constants/app_constants.dart';
import 'package:doctors_appointment/src/core/data_source/local/shared.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/src/features/search/bloc/whole_search_bloc.dart';
import 'package:doctors_appointment/src/features/search/screen/search_delegate.dart';
import 'package:doctors_appointment/src/features/search/screen/search_on_former_result.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholeDoctorsSearch extends StatefulWidget {
  const WholeDoctorsSearch({super.key});

  @override
  State<WholeDoctorsSearch> createState() => _WholeDoctorsSearchState();
}

class _WholeDoctorsSearchState extends State<WholeDoctorsSearch> {


  @override
  void initState() {
    context.read<WholeSearchBloc>().add(ResetSearchState());
    super.initState();
  }
  @override
  void dispose() {
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
            InkWell(
              onTap: () => showSearch(context: context, delegate: AppSearch()),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.grey[200]
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: context.horizontalSymmetricPadding(16.w),
                      child: const Icon(Icons.search),
                    ),
                    const MyText(text: 'Search')
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(text: 'Recent search', fontSize: 18.sp, fontWeight: FontWeight.w500,),
                TextButton(
                    onPressed: ()async {
                      PatientsDataSource
                          .getInstance()
                          .initRef(CacheHelper.getInstance().getUserData()![1])
                          .child('searchHistory').remove();
                    },
                    child: MyText(
                      text: 'Clear History',
                      fontSize: 14.sp,
                      color: Constants.appColor,
                    )
                )
              ],
            ),
            Flexible(
              child: FirebaseAnimatedList(
                // key: ValueKey<bool>(_anchorToBottom),
                query: PatientsDataSource
                    .getInstance()
                    .initRef(CacheHelper.getInstance().getUserData()![1])
                    .child('searchHistory'),
                itemBuilder: (context, snapshot, animation, index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: InkWell(
                      onTap: () => context.normalNewRoute(
                          SearchOnFormerResult(pattern: snapshot.key.toString()
                          )
                      ),
                      child: ListTile(
                        leading: Icon(Icons.access_time, color: Colors.grey[400],),
                        title: MyText(
                          text: snapshot.key.toString(),
                            // text: '${(snapshot.value as Map)['searchAbout']}',
                            color: Colors.grey[400]
                        ),
                        trailing: IconButton(
                          onPressed: ()async{
                            snapshot.child(snapshot.key.toString()).ref.remove();
                          },
                          icon: Icon(Icons.delete, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
