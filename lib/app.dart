import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/post.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/model/remote/stripe/repos/post.dart';
import 'package:doctors_appointment/model/remote/stripe/service/stripe_connection.dart';
import 'package:doctors_appointment/view/auth/login/screen.dart';
import 'package:doctors_appointment/view/auth/sign_up/screen.dart';
import 'package:doctors_appointment/view/book_appointment/main/main_screen.dart';
import 'package:doctors_appointment/view/book_appointment/screens/date_time.dart';
import 'package:doctors_appointment/view/home/home.dart';
import 'package:doctors_appointment/view/error_builder/unexpected_error_handler.dart';
import 'package:doctors_appointment/view/recommended_doctors/screen.dart';
import 'package:doctors_appointment/view/specialities/screen.dart';
import 'package:doctors_appointment/view_model/auth/auth_cubit.dart';
import 'package:doctors_appointment/view_model/home/cubit.dart';
import 'package:doctors_appointment/view_model/part_of_test/main_file.dart';
import 'package:doctors_appointment/view_model/payment/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helpers/data_types/permession_process_model.dart';
import 'helpers/helper_methods/handle_permissions.dart';
import 'model/local/shared.dart';
import 'model/remote/api_service/repositories/get.dart';
import 'model/remote/api_service/service/dio_connection.dart';

class MediMeetApp extends StatefulWidget {
  const MediMeetApp({super.key});
  @override
  State<MediMeetApp> createState() => _MediMeetAppState();
}

class _MediMeetAppState extends State<MediMeetApp> {

  @override
  void initState() {
    PatientsDataSource.getInstance().initRef(
        CacheHelper.getInstance().getUserData()![1]
    );
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
          BlocProvider<AuthCubit>(create: (context) => AuthCubit(PostRepo(apiService: DioConnection.getInstance()))),
          BlocProvider<HomeCubit>(  create: (context) => HomeCubit(
              getRepo: GetRepo(apiService: DioConnection.getInstance()),
              postRepo: PostRepo(apiService: DioConnection.getInstance())
          ),),
          BlocProvider<PaymentCubit>(create: (context) => PaymentCubit(
            StripePostRepo(apiService: StripeConnection.getInstance())
          )),
          // Add more providers as needed
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