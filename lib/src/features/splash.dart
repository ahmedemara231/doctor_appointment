import 'dart:async';
import 'package:doctors_appointment/generated/assets.dart';
import 'package:doctors_appointment/src/core/helpers/base_extensions/context/routes.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import '../core/data_source/local/shared.dart';
import '../core/helpers/helper_methods/internet_connection_interceptor.dart';
import 'auth/screens/login_screen.dart';
import 'bottom_bar/screen.dart';

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
      switch (userLoginState) {
        case true:
          context.removeOldRoute(const Login());
        default:
          context.removeOldRoute(const BottomBar());
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
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(Assets.imagesSplash2),
            SvgPicture.asset(Assets.imagesSplash1),
          ],
        ),
      ),
    );
  }
}