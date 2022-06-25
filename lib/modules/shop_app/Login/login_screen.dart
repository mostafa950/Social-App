import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/Login/login%20cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_app/Login/login%20cubit/login_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constacne.dart';
import 'package:shop_app/shared/network/local.dart';

import '../registger/register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  bool _isValidate() {
    var form = _keyForm.currentState;
    return form!.validate() ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          if (state.shopLoginModel.status!){
            CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token).then((value){
              showToast(message: state.shopLoginModel.message!, state: ToastStates.success);
              navigateToFinish(context, ShopLayout());
            } );
            token = ShopLoginCubit.get(context).loginModel!.data!.token;
          }
          else
            {
              showToast(message: state.shopLoginModel.message!, state: ToastStates.failed);
            }
        }
      },
      builder: (context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
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
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormedFailed(
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
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormedFailed(
                        type: null,
                        hintText: 'Enter your password',
                        controller: passwordController,
                        prefixIcon: Icons.lock,
                        isSecure: cubit.isSecure,
                        sufPressed: (){
                          cubit.changePasswordVisibility();
                        },
                        suffixIcon: cubit.fabIcon,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      conditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: inputButton(
                          text: 'login',
                          color: Colors.blue,
                          onTap: () {
                            print("State is ${state.toString()}");
                            if (_keyForm.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: Center(
                          child: CircularProgressIndicator(),
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
                              navigateTo(context, RegisterScreen());
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
    );
  }
}
