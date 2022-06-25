import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app_model/board_model.dart';
import 'package:shop_app/models/shop_app_model/login_model.dart';
import 'package:shop_app/modules/shop_app/registger/register%20cubit/register_state.dart';
import 'package:shop_app/shared/network/end%20points.dart';
import 'package:shop_app/shared/network/remote.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  ShopUserDataModel? registerModel;
  void userRegister({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      language: 'en',
      data: {
        'name' : name,
        'phone' : phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      registerModel = ShopUserDataModel.fromJson(value.data);
      print(registerModel?.data?.email);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
  bool isSecure = true;
  IconData fabIcon = Icons.visibility_off;

  void changePasswordVisibility() {
    isSecure = !isSecure;
    fabIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(RegisterChangePasswordVisibilityState());
  }
}
