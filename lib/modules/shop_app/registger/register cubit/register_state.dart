import 'package:shop_app/models/shop_app_model/board_model.dart';
import 'package:shop_app/models/shop_app_model/login_model.dart';


abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final ShopUserDataModel shopUserDataModel;

  RegisterSuccessState(this.shopUserDataModel);
}

class RegisterErrorState extends RegisterState {
  final String? error;
  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState {}
