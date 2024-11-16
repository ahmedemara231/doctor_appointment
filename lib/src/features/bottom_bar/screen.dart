import 'package:doctors_appointment/src/core/constants/app_constants.dart';
import 'package:doctors_appointment/src/features/home/screens/home.dart';
import 'package:doctors_appointment/src/features/home/screens/user_chats.dart';
import 'package:doctors_appointment/src/features/search/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/data_source/local/shared.dart';
import '../../core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import '../Profile/screens/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> screens = const [
    Home(),
    UserChats(),
    WholeDoctorsSearch(),
    Profile()
  ];

  int currentPage = 0;

  void changePage(int index) {
    setState(() {currentPage = index;});
  }

  @override
  void initState() {
    PatientsDataSource.getInstance().initRef(
        CacheHelper.getInstance().getUserData()![1]
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.appColor,
        animationDuration: const Duration(milliseconds: 250),
        height: 65.h,
        // index: ,
        items: <Widget>[
          Icon(Icons.home, size: 22.sp),
          Icon(Icons.chat_outlined, size: 22.sp),
          Icon(Icons.search, size: 22.sp),
          Icon(Icons.person, size: 22.sp),
        ],
        onTap: changePage,
      ),
      body: screens[currentPage],
    );
  }
}
