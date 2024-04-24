import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/Features/gallery/peresentation/screen/gallery_screen.dart';
import 'package:promina_task/Features/login/peresentation/cubit/user_login_cubit.dart';
import 'package:promina_task/core/cach_helper.dart/cache_helper.dart';
import 'package:promina_task/core/routing/routes.dart';
import 'package:promina_task/core/utils/spacing.dart';
import 'package:promina_task/core/widgts/custom_button.dart';
import 'package:promina_task/core/widgts/custom_text_form_field.dart';
import 'package:promina_task/core/widgts/titles_text_widget.dart';
import 'package:promina_task/injection_container.dart ' as di;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userNameController = TextEditingController();
  var passswordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/log in.png')),
          Positioned(
              top: .2 * size.height,
              left: .3 * size.width,
              child: const Column(
                children: [
                  Text(
                    "\t\t\tMy \nGellary",
                    style: TextStyle(color: Color(0xff4A4A4A), fontSize: 50),
                  ),
                ],
              )),
          Positioned(
            top: .4 * size.height,
            left: .1 * size.width,
            right: .1 * size.width,
            child: Container(
              width: 345,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color(0x80FFFFFF),
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocProvider(
                      create: (context) => di.sl<UserLoginCubit>(),
                      child: BlocConsumer<UserLoginCubit, UserLoginState>(
                        listener: (context, state) {
                          if (state is UserLoginIsLoading) {
                            log("loading");
                          } else if (state is UserLoginIsSuccess) {
                            CacheHelper.saveData(key: 'LoginDon', value: true);
                            CacheHelper.saveData(
                                key: 'name',
                                value: state.successModel.user.name);
                            CacheHelper.saveData(
                                    key: 'token',
                                    value: state.successModel.token)
                                .then((value) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.galleryScreen);
                            });

                            log(state.successModel.user.email.toString());
                          } else if (state is UserLoginIsError) {
                            log(state.errorMessage.errormessage.toString());
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const TitlesTextWidget(label: 'LOG IN'),
                              verticalSpace(20),
                              Container(
                                  width: 282.42.w,
                                  height: 46.11.h,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF7F7F7),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xff707070),
                                      )),
                                  child: AppTextFormField(
                                      controller: userNameController,
                                      hintText: 'User Name',
                                      type: TextInputType.emailAddress,
                                      readonly: false,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "email must not be empty";
                                        }
                                      })),
                              verticalSpace(20),
                              Container(
                                  width: 282.42.w,
                                  height: 46.11.h,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF7F7F7),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xff707070),
                                      )),
                                  child: AppTextFormField(
                                      hintText: 'Password',
                                      controller: passswordController,
                                      isObscureText: true,
                                      type: TextInputType.visiblePassword,
                                      readonly: false,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "password must not be empty ";
                                        }
                                      })),
                              verticalSpace(20),
                              state is UserLoginIsLoading
                                  ? const CircularProgressIndicator()
                                  : AppTextButton(
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          BlocProvider.of<UserLoginCubit>(
                                                  context)
                                              .userLogin(
                                                  userNameController.text,
                                                  passswordController.text);
                                        }
                                      },
                                      buttonText: 'SUBMIT',
                                      backgroundColor: const Color(0xff7BB3FF),
                                      textStyle:
                                          const TextStyle(color: Colors.white),
                                    )
                            ],
                          );
                        },
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
