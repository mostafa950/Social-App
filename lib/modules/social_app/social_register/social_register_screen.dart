import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/social_app/social_layout.dart';
import 'package:shop_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:shop_app/modules/social_app/social_register/cubit/social_register_state.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit/social_register_cubit.dart';

class SocialRegisterScreen extends StatefulWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SocialRegisterScreen> createState() => _SocialRegisterScreenState();
}

class _SocialRegisterScreenState extends State<SocialRegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var nameController = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialRegisterErrorState) {
            showToast(
                message: state.error.toString(), state: ToastStates.failed);
          } else if (state is SocialCreateUserSuccessState) {
            showToast(
              message: 'success',
              state: ToastStates.success,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'register now to communicate with our friends',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultTextFormedFailed(
                            onTap: () {},
                            hintText: 'Your name',
                            controller: nameController,
                            prefixIcon: Icons.person,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              } else
                                return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultTextFormedFailed(
                            onTap: () {},
                            hintText: 'Your phone',
                            controller: phoneController,
                            prefixIcon: Icons.phone,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty ||
                                  value.toString().length < 11) {
                                return value.isEmpty
                                    ? 'This field is required'
                                    : 'the number phone is short';
                              } else
                                return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultTextFormedFailed(
                            onTap: () {},
                            hintText: 'Your email address',
                            controller: emailController,
                            prefixIcon: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              } else
                                return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: defaultTextFormedFailed(
                            hintText: 'Enter your password',
                            controller: passwordController,
                            prefixIcon: Icons.lock,
                            isSecure: SocialRegisterCubit.get(context).isSecure,
                            sufPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            suffixIcon:
                                SocialRegisterCubit.get(context).fabIcon,
                            validate: (String? value) {
                              if (value!.isEmpty ||
                                  value.toString().length < 8) {
                                return value.isEmpty
                                    ? 'This field is required'
                                    : 'the password is short';
                              } else
                                return null;
                            },
                            type: null,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: conditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: inputButton(
                              text: 'register',
                              color: Colors.blue,
                              onTap: () {
                                print("State is ${state.toString()}");
                                if (_keyForm.currentState!.validate()) {
                                  SocialRegisterCubit.get(context)
                                      .userSocialRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                            fallback: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
