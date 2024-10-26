import 'package:doctors_appointment/helpers/app_widgets/login_register_widger.dart';
import 'package:doctors_appointment/helpers/base_extensions/context/padding.dart';
import 'package:doctors_appointment/helpers/data_types/register_inputs.dart';
import 'package:doctors_appointment/helpers/data_types/register_widget_inputs.dart';
import 'package:doctors_appointment/helpers/helper_methods/validators.dart';
import 'package:doctors_appointment/view/login/widgets/text_field.dart';
import 'package:doctors_appointment/view/sign_up/widgets/select_gender.dart';
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
  late TextEditingController nameCont;
  late TextEditingController emailCont;

  late TextEditingController phoneCont;
  late TextEditingController passCont;

  late TextEditingController confirmPassCont;

  late List<RegisterWidgetInputs> textFieldsProperties;

  @override
  void initState() {
    nameCont = TextEditingController();
    emailCont = TextEditingController();
    phoneCont = TextEditingController();
    passCont = TextEditingController();
    confirmPassCont = TextEditingController();

    textFieldsProperties = [
      RegisterWidgetInputs(
          hintText: 'Name',
          obscureText: false,
          cont: nameCont,
          validation: Validators.validateEmpty
      ),
      RegisterWidgetInputs(
          hintText: 'Email',
          obscureText: false,
          cont: emailCont,
          validation: Validators.validateEmail
      ),
      RegisterWidgetInputs(
          hintText: 'Phone Number',
          obscureText: false,
          cont: phoneCont,
          validation: Validators.validatePhone
      ),
      RegisterWidgetInputs(
          hintText: 'Password',
          obscureText: true,
          cont: passCont,
          validation: Validators.validatePassword
      ),
      RegisterWidgetInputs(
          hintText: 'Confirm Password',
          obscureText: false,
          cont: confirmPassCont,
          validation: (p0) =>  Validators.validatePasswordConfirm(p0, passCont.text),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    nameCont.dispose();
    emailCont.dispose();
    passCont.dispose();
    confirmPassCont.dispose();
    phoneCont.dispose();
    super.dispose();
  }

  String gender = 0.toString();
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
              Column(
                children: List.generate(
                  textFieldsProperties.length,
                  (index) => Padding(
                    padding: context.verticalSymmetricPadding(12.h),
                    child: AuthTextFields(
                        hintText: textFieldsProperties[index].hintText,
                        obscureText: textFieldsProperties[index].obscureText,
                        cont: textFieldsProperties[index].cont,
                        validation: textFieldsProperties[index].validation
                    ),
                  )
                ),
              ),
              SelectGender(
                onSelectGender: (selectedGender) => gender = selectedGender,
              ),
              LoginRegisterWidget(
                title: 'Sign up',
                secondTitle: 'Already have an account?  ',
                secondOption: 'Login',
                onPressed: () async {
                  context.read<AuthCubit>().signUp(
                      RegisterInputs(
                          email: emailCont.text,
                          password: passCont.text,
                          phone: phoneCont.text,
                          name: nameCont.text,
                          passConfirmation: confirmPassCont.text,
                          gender: gender,
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