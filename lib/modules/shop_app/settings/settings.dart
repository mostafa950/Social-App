import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../../layout/shop_app/shop cubit/shop_cubit.dart';
import '../../../shared/network/local.dart';
import '../../../shared/styles/colors.dart';
import '../Login/login_screen.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        emailController.text = model.data!.email!;
        if (ShopCubit.get(context).userModel!.data != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    if (state is UpdateUserDataLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormedFailed(
                      onTap: (){},
                      controller: nameController,
                      name: 'name',
                      type: TextInputType.text,
                      prefixIcon: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'this filed is required';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormedFailed(
                      onTap: (){},
                      controller: phoneController,
                      name: 'phone',
                      type: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'this filed is required';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormedFailed(
                      onTap: (){},
                      controller: emailController,
                      name: 'email',
                      type: TextInputType.text,
                      prefixIcon: Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'this filed is required';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    inputButton(
                      color: defaultColor,
                      text: 'SIGN OUT',
                      onTap: () {
                        CacheHelper.removeData(
                          key: 'token',
                        );
                        navigateTo(context, LoginScreen());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    inputButton(
                      color: defaultColor,
                      text: 'update',
                      onTap: () {
                        if (_keyForm.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            phone: phoneController.text,
                            name: nameController.text,
                            email: emailController.text,
                          );
                        }

                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
