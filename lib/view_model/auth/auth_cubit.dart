import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/model/remote/api_service/repositories/post.dart';
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
      onLoginSuccess(token: data['token'], name: data['username']);

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
})async {
    await SecureStorage.getInstance().setData(key: 'token', value: token);
    log('${await SecureStorage.getInstance().readData(key: 'token')}');
    await CacheHelper.getInstance().setData(
        key: 'userData',
        value: <String>[
          name,
        ]
    );
    await createCustomer();
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