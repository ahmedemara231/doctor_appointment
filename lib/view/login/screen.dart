import 'package:doctors_appointment/constants/app_constants.dart';
import 'package:doctors_appointment/helpers/app_widgets/login_register_widger.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/base_widgets/text.dart';
import 'package:doctors_appointment/helpers/helper_methods/validators.dart';
import 'package:doctors_appointment/view/login/widgets/remember_and_forgot_pass.dart';
import 'package:doctors_appointment/view/login/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  Login({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.horizontalSymmetricPadding(16.w),
          child: Column(
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
              LoginRegisterWidget(
                  title: 'Login',
                  onPressed: () {},
                  secondTitle: 'Don\'t have an account yet? ',
                  secondOption: 'Sign up'
              ),
            ],
          ),
        ),
      ),
    );
  }
}