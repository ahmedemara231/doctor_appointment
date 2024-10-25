import 'dart:async';
import 'package:flutter/material.dart';
import '../helpers/helper_methods/internet_connection_interceptor.dart';
import '../model/local/shared.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get userLoginState {
    List<String>? userData = CacheHelper.getInstance().shared.getStringList('userData');

    switch (userData) {
      case null:
        return true;
      case []:
        return true;
      default:
        return false;
    }
  }

  Future<void> _navigate() async {
    Timer(
        const Duration(seconds: 2), () {
      switch (CacheHelper.getInstance().shared.getBool('finishOnBoarding'))
      {
        case true:
          switch (userLoginState)
          {
            case true:
              // context.removeOldRoute(const Login());
            default:
              // context.removeOldRoute(const BottomNavBar());
          }
        default:
          // context.removeOldRoute(const OnBoarding());
      }
    });
  }

  @override
  void initState() {
    _navigate().whenComplete(
            () => CheckInternetConnection().startInternetInterceptor(context)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: const Center(
        // child: Image.asset(
        //   'images/app_logo.png',
        //   color: Colors.white,
        // ),
      ),
    );
  }
}