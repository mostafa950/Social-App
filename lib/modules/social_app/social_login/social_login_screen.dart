import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/social_app/social_layout.dart';
import 'package:shop_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:shop_app/modules/social_app/social_login/cubit/social_login_cubit.dart';
import 'package:shop_app/modules/social_app/social_login/cubit/social_login_state.dart';
import 'package:shop_app/modules/social_app/social_register/cubit/social_register_state.dart';
import 'package:shop_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local.dart';

class SocialLoginScreen extends StatefulWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
                message: state.error.toString(), state: ToastStates.failed);
          } else if (state is SocialLoginSuccessState) {
            showToast(message: 'login success', state: ToastStates.success);
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateTo(context, SocialLayout());
          }
        },
        builder: (context, state) {
          SocialLoginCubit cubit = SocialLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'login now to communicate with our friends',
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
                            type: null,
                            hintText: 'Enter your password',
                            controller: passwordController,
                            prefixIcon: Icons.lock,
                            isSecure: SocialLoginCubit.get(context).isSecure,
                            sufPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            suffixIcon: SocialLoginCubit.get(context).fabIcon,
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
                          child: conditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: inputButton(
                              text: 'login',
                              color: Colors.blue,
                              onTap: () {
                                print("State is ${state.toString()}");
                                if (_keyForm.currentState!.validate())
                                {
                                  cubit.userSocialLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            textButton(
                              text: 'Register',
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                            ),
                          ],
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
