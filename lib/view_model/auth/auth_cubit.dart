import 'dart:developer';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/post_repo/post.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/services/patients_service/data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/data_types/register_inputs.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthState.initial());

  late PostRepo repo;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(state: States.loginLoading));

    final loginResponse = await repo.login(
        email: email,
        password: password
    );

    if(loginResponse.isSuccess()){
      final data = loginResponse.getOrThrow().data['data'];
      onLoginSuccess(
          token: data['token'],
          name: data['username'],
          email: email.split("@").first,
      );

      emit(state.copyWith(
          state: States.loginSuccess,
          resultMsg: 'Login Successful'
      ));
    }
    else{
      log('failed');
      emit(state.copyWith(
          state: States.loginError,
          resultMsg: loginResponse.tryGetError()?.message
      ));
    }
  }

  Future<void> onLoginSuccess({
    required String token,
    required String name,
    required String email,
})async {
    await cacheDataOnLoginSuccess(token: token, name: name, email: email);
    await registerOnRealtimeDatabase(name: name, email: email);
    await createCustomer();
  }

  Future<void> cacheDataOnLoginSuccess({
    required String token,
    required String name,
    required String email,
  })async{
    await SecureStorage.getInstance().setData(key: 'token', value: token);
    await CacheHelper.getInstance().setData(
        key: 'userData',
        value: <String>[
          name,
          email
        ]
    );
  }

  Future<void> registerOnRealtimeDatabase({required String name, required String email})async{
    PatientsDataSource.getInstance()
      .initRef(email);
  }
  Future<void> createCustomer() async{
    // final cusId = await StripePostRepo(
    //     apiService: StripeConnection.getInstance()).createCustomer(
    //     name: CacheHelper.getInstance().getUserData()![0]
    // );
    // log(cusId.getOrThrow());
    // SecureStorage.getInstance().setData(
    //     key: 'customerId',
    //     value: cusId.getOrThrow()
    // );
  }

  Future<void> signUp(RegisterInputs inputs) async {
    emit(state.copyWith(state: States.registerLoading));
    final signUpResponse = await repo.signUp(inputs);
    if(signUpResponse.isSuccess()){
      PatientsDataSource.getInstance().registerAccountOnRealtimeDatabase(
          name: inputs.name, email: inputs.email
      );
      emit(state.copyWith(
          state: States.registerSuccess,
          resultMsg: 'Sign up Successful'
      ));
    }
    else{
      emit(state.copyWith(
          state: States.registerError,
          resultMsg: 'Sign up Failed'
      ));
    }
  }
}