import 'package:shop_app/models/shop_app_model/login_model.dart';

abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {
  // final ShopUserDataModel shopUserDataModel;
  //
  // SocialRegisterSuccessState(this.shopUserDataModel);
}

class SocialRegisterErrorState extends SocialRegisterState {
  final String? error;
  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterState {}

class SocialCreateUserErrorState extends SocialRegisterState {
  final String? error;
  SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterState {}
