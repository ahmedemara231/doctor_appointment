import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Api_constants.dart';
import 'package:doctors_appointment/model/remote/api_service/service/Lang_methods.dart';
import 'package:doctors_appointment/model/remote/api_service/service/dio_connection.dart';
import 'package:doctors_appointment/model/remote/api_service/service/request_model/request_model.dart';
import 'package:svg_flutter/svg.dart';
import '../../helpers/data_types/register_inputs.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(state: States.loginLoading));
    final loginResponse = await DioConnection.getInstance().callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.login,
          data: {'email': email, 'password': password},
        )
    );
    if(loginResponse.isSuccess()){
      final data = loginResponse.getOrThrow().data['data'];
      onLoginSuccess(token: data['token'], name: data['username']);

      emit(state.copyWith(
          state: States.loginSuccess,
          resultMsg: 'Login Successful'
      ));
    }
    else{
      emit(state.copyWith(
          state: States.loginError,
          resultMsg: 'Login Failed'
      ));
    }
  }

  Future<void> onLoginSuccess({
    required String token,
    required String name,
})async {
    await SecureStorage.getInstance().setData(key: 'token', value: token);
    log('${await SecureStorage.getInstance().readData(key: 'token')}');
    await CacheHelper.getInstance().setData(
        key: 'userData',
        value: <String>[
          name,
        ]
    );
  }
  
  Future<void> signUp(RegisterInputs inputs) async {
    emit(state.copyWith(state: States.registerLoading));
    final loginResponse = await DioConnection.getInstance().callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.signUp,
          data: inputs.toJson(),
        )
    );
    if(loginResponse.isSuccess()){
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