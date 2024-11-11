import 'package:doctors_appointment/src/core/constants/app_constants.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/dio_connection.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/src/core/data_source/remote/stripe/repos/post.dart';
import 'package:doctors_appointment/src/core/data_source/remote/stripe/service/stripe_connection.dart';
import 'package:doctors_appointment/src/core/helpers/data_types/permession_process_model.dart';
import 'package:doctors_appointment/src/core/helpers/helper_methods/handle_permissions.dart';
import 'package:doctors_appointment/src/features/auth/blocs/auth/auth_cubit.dart';
import 'package:doctors_appointment/src/features/auth/data_source/auth_data_source.dart';
import 'package:doctors_appointment/src/features/auth/repositories/repo.dart';
import 'package:doctors_appointment/src/features/auth/screens/login_screen.dart';
import 'package:doctors_appointment/src/features/home/blocs/chat/cubit.dart';
import 'package:doctors_appointment/src/features/home/blocs/home/cubit.dart';
import 'package:doctors_appointment/src/features/home/blocs/payment/cubit.dart';
import 'package:doctors_appointment/src/features/home/data_source/home_data_source.dart';
import 'package:doctors_appointment/src/features/home/repositories/get.dart';
import 'package:doctors_appointment/src/features/home/repositories/post.dart';
import 'package:doctors_appointment/src/features/home/screens/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MediMeetApp extends StatefulWidget {
  const MediMeetApp({super.key});
  @override
  State<MediMeetApp> createState() => _MediMeetAppState();
}

class _MediMeetAppState extends State<MediMeetApp> {

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

  @override
  Widget build(BuildContext context) {
      return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit(
              AuthRepo(AuthDataSource(DioConnection.getInstance()))
          )),
          BlocProvider<HomeCubit>(  create: (context) => HomeCubit(
              getRepo: HomeGetRepo(HomeDataSource(DioConnection.getInstance())),
              postRepo: HomePostRepo(HomeDataSource(DioConnection.getInstance()))
          ),),
          BlocProvider<PaymentCubit>(create: (context) => PaymentCubit(
            StripePostRepo(apiService: StripeConnection.getInstance())
          )),
          BlocProvider<ChatCubit>(create: (context) => ChatCubit(
            homeGetRepo: HomeGetRepo(HomeDataSource(DioConnection.getInstance())),
            homePostRepo: HomePostRepo(HomeDataSource(DioConnection.getInstance(), PatientsDataSource.getInstance()))
          )),
        ],
        child: MaterialApp(
          // shortcuts: ,
          // actions: ,
          // navigatorObservers: [AppNavigationObserver()],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'MediMeet'.tr(), // give the translation of App Name for example
          debugShowCheckedModeBanner: false,
          navigatorKey: Constants.navigatorKey,
          routes: {
            '/login': (context) => const Login(),
          },
          // theme: CacheHelper.getInstance().shared.getBool('appTheme') == false
          //     ? ThemeData.light()
          //     : ThemeData.dark(),
          home: Home(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}