import 'package:shop_app/models/shop_app_model/board_model.dart';
import 'package:shop_app/models/shop_app_model/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final ShopUserDataModel shopLoginModel;

  LoginSuccessState(this.shopLoginModel);
}

class LoginErrorState extends LoginState {
  final String? error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginState {}
