import 'package:doctors_appointment/helpers/app_widgets/login_register_widger.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/data_types/register_inputs.dart';
import 'package:doctors_appointment/helpers/helper_methods/validators.dart';
import 'package:doctors_appointment/view/login/widgets/text_field.dart';
import 'package:doctors_appointment/view_model/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../../helpers/base_widgets/text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController emailCont;

  late TextEditingController passCont;

  late TextEditingController phoneCont;

  @override
  void initState() {
    emailCont = TextEditingController();
    passCont = TextEditingController();
    phoneCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailCont.dispose();
    passCont.dispose();
    phoneCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: context.horizontalSymmetricPadding(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'Create Account',
                color: Constants.appColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              MyText(
                text:
                'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                color: Colors.grey,
                maxLines: 5,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20.h,
              ),
              AuthTextFields(
                  hintText: 'Email',
                  obscureText: false,
                  cont: emailCont,
                  validation: Validators.validateEmail
              ),
              SizedBox(height: 12.h),
              AuthTextFields(
                  hintText: 'Password',
                  obscureText: true,
                  cont: passCont,
                  validation: Validators.validatePassword
              ),
              SizedBox(height: 12.h),
              AuthTextFields(
                  hintText: 'Phone Number',
                  obscureText: false,
                  cont: phoneCont,
                  validation: Validators.validatePhone
              ),
              SizedBox(height: 12.h),
              LoginRegisterWidget(
                title: 'Sign up',
                secondTitle: 'Already have an account?  ',
                secondOption: 'Login',
                onPressed: () async {
                  context.read<AuthCubit>().signUp(
                      RegisterInputs(
                          email: emailCont.text,
                          password: passCont.text,
                          phone: phoneCont.text
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}