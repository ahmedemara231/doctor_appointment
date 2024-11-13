import 'package:doctors_appointment/src/core/constants/app_constants.dart';
import 'package:doctors_appointment/src/core/data_source/local/secure.dart';
import 'package:doctors_appointment/src/core/data_source/local/shared.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/src/core/data_source/remote/stripe/service/stripe_constants.dart';
import 'package:doctors_appointment/src/core/shared/observers/bloc_observer.dart';
import 'package:doctors_appointment/src/core/shared/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:feedback/feedback.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().setUpBlocs();
  await CacheHelper.getInstance().cacheInit();
  SecureStorage.getInstance().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PatientsDataSource.getInstance().databaseConfig();

  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  Constants.configLoading();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  //   FlutterError.dumpErrorToConsole(errorDetails);
  //   runApp(MyErrorWidget(errorDetails: errorDetails));
  // };

  // asynchronous errors
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  Stripe.publishableKey = StripeConstants.publishableKey;
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'SA')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const BetterFeedback(
            child: MediMeetApp()
        )
    ),
  );
}
