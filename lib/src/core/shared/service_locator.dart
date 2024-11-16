import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:doctors_appointment/src/features/auth/bloc/auth_cubit.dart';
import 'package:doctors_appointment/src/features/auth/data_source/auth_data_source.dart';
import 'package:doctors_appointment/src/features/auth/repositories/repo.dart';
import 'package:doctors_appointment/src/features/search/bloc/whole_search_bloc.dart';
import 'package:doctors_appointment/src/features/search/data_source/whole_search_data_source.dart';
import 'package:doctors_appointment/src/features/search/repositories/search_repo.dart';
import 'package:get_it/get_it.dart';
import '../../features/home/blocs/chat/cubit.dart';
import '../../features/home/blocs/home/cubit.dart';
import '../../features/home/blocs/payment/cubit.dart';
import '../../features/home/data_source/home_data_source.dart';
import '../../features/home/repositories/get.dart';
import '../../features/home/repositories/post.dart';
import '../data_source/remote/api_service/service/dio_connection.dart';
import '../data_source/remote/stripe/repos/post.dart';
import '../data_source/remote/stripe/service/stripe_connection.dart';

class ServiceLocator{
  final _getIt = GetIt.instance;

  void setUpBlocs(){
    _getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
        AuthRepo(
            AuthDataSource(
                DioConnection.getInstance()
            )
        )
    ));
    _getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(
        getRepo: HomeGetRepo(
            HomeDataSource(
                DioConnection.getInstance(),
                PatientsDataSource.getInstance()
            )
        ),
        postRepo: HomePostRepo(HomeDataSource(
            DioConnection.getInstance(),
            PatientsDataSource.getInstance()
        ))
    ));
    _getIt.registerLazySingleton<PaymentCubit>(() => PaymentCubit(
        StripePostRepo(apiService: StripeConnection.getInstance())
    ));
    _getIt.registerLazySingleton<ChatCubit>(() => ChatCubit(
        homeGetRepo: HomeGetRepo(
            HomeDataSource(
                DioConnection.getInstance(),
                PatientsDataSource.getInstance()
            )),
        homePostRepo: HomePostRepo(
            HomeDataSource(
                DioConnection.getInstance(),
                PatientsDataSource.getInstance()
            )
        )
    ));
    _getIt.registerLazySingleton<WholeSearchBloc>(() => WholeSearchBloc(
      SearchRepo(WholeSearchDataSource(DioConnection.getInstance()))
    ));

  }
}