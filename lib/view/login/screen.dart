import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/app_loading_button.dart';
import 'package:doctors_appointment/helpers/app_widgets/login_register_widger.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/animated_snack_bar.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/helpers/helper_methods/validators.dart';
import 'package:doctors_appointment/view/login/widgets/remember_and_forgot_pass.dart';
import 'package:doctors_appointment/view/login/widgets/text_field.dart';
import 'package:doctors_appointment/view_model/auth/auth_cubit.dart';
import 'package:doctors_appointment/view_model/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_icon_button/loading_icon_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  LoadingButtonController btnController = LoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.horizontalSymmetricPadding(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: 'Welcome Back',
                color: Constants.appColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              MyText(
                text:
                'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in',
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20.h,
              ),
              AuthTextFields(
                  hintText: 'Email',
                  obscureText: false,
                  cont: emailController,
                  validation: Validators.validateEmail),
              SizedBox(height: 16.sp),
              AuthTextFields(
                hintText: 'Password',
                obscureText: true,
                cont: passwordController,
                validation: Validators.validatePassword,
              ),
              const RememberAndForgotPass(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  switch(state.currentState){
                    case States.loginSuccess:
                      btnController.success();
                      waitAndReset();
                      AppSnakeBar.show(context, title: state.resultMsg);

                    case States.loginError:
                      btnController.error();
                      waitAndReset();
                      AppSnakeBar.show(context, title: state.resultMsg, type: AnimatedSnackBarType.error);

                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  return LoginRegisterWidget(
                      title: 'Login',
                      onPressed: () async {
                        context.read<AuthCubit>().login(
                            emailController.text,
                            passwordController.text
                        );
                      },
                    secondTitle: 'Don\'t have an account yet? ',
                    secondOption: 'Sign up',
                    btnController: btnController,
                  );
                },
              ),
              // AppLoadingButton(),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> waitAndReset()async{
    await Future.delayed(const Duration(seconds: 2));
    btnController.reset();
  }
}