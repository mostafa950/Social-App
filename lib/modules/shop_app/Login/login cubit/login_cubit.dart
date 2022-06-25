import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app_model/board_model.dart';
import 'package:shop_app/models/shop_app_model/login_model.dart';
import 'package:shop_app/modules/shop_app/Login/login%20cubit/login_state.dart';
import 'package:shop_app/shared/network/end%20points.dart';
import 'package:shop_app/shared/network/remote.dart';



class ShopLoginCubit extends Cubit<LoginState> {
  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopUserDataModel? loginModel;
  void userLogin({
    String? email,
    String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      language: 'en',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopUserDataModel.fromJson(value.data);
      print(loginModel?.data?.email);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isSecure = true;
  IconData fabIcon = Icons.visibility_off;

  void changePasswordVisibility() {
    isSecure = !isSecure;
    fabIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibilityState());
  }
}
