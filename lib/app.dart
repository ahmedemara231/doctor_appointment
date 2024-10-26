import 'package:doctors_appointment/view/home/home.dart';
import 'package:doctors_appointment/view/login/screen.dart';
import 'package:doctors_appointment/view/route_observer.dart';
import 'package:doctors_appointment/view/sign_up/screen.dart';
import 'package:doctors_appointment/view/sign_up/widgets/select_gender.dart';
import 'package:doctors_appointment/view_model/auth/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helpers/data_types/permession_process_model.dart';
import 'helpers/helper_methods/handle_permissions.dart';
import 'model/local/shared.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    checkPermission(
      PermissionProcessModel(
        permissionClient: PermissionClient.notification,
        onPermissionGranted: () {},
        onPermissionDenied: () {},
      ),
    );
    super.initState();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
      return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        ],
        child: MaterialApp(
          // shortcuts: ,
          // actions: ,
          // navigatorObservers: [AppNavigationObserver()],
          // localizationsDelegates: context.localizationDelegates,
          locale: context.locale, // context.setLocal
          supportedLocales: context.supportedLocales,
          title: 'App Name'.tr(), // give the translation of App Name for example
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          // theme: CacheHelper.getInstance().shared.getBool('appTheme') == false
          //     ? ThemeData.light()
          //     : ThemeData.dark(),
          home:  SignUp(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}