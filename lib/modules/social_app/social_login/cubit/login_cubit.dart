import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/social_app/social_login/cubit/login_state.dart';
import 'package:shop_app/shared/network/local.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userSocialLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print('error founded in user login social mostafa ${error.toString()}');
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  bool isSecure = true;
  IconData fabIcon = Icons.visibility_off;

  void changePasswordVisibility() {
    isSecure = !isSecure;
    fabIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}
