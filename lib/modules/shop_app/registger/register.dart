import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/registger/register%20cubit/register_cubit.dart';
import 'package:shop_app/modules/shop_app/registger/register%20cubit/register_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constacne.dart';
import 'package:shop_app/shared/network/local.dart';



class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var nameController = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            if (state.shopUserDataModel.status!){
              CacheHelper.saveData(key: 'token', value: state.shopUserDataModel.data!.token).then((value){
                showToast(message: state.shopUserDataModel.message!, state: ToastStates.success);
                navigateToFinish(context, ShopLayout());
              } );
              token = RegisterCubit.get(context).registerModel!.data!.token;
            }
            else
            {
              showToast(message: state.shopUserDataModel.message!, state: ToastStates.failed);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormedFailed(
                          onTap: (){},
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
                        SizedBox(
                          height: 20,
                        ),

                        defaultTextFormedFailed(
                          onTap: (){},
                          hintText: 'Your phone',
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          type: TextInputType.phone,
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
                          onTap: (){},
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
                          type: null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        conditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: inputButton(
                            text: 'register',
                            color: Colors.blue,
                            onTap: () {
                              print("State is ${state.toString()}");
                              if (_keyForm.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
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
