import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/social_app_model/social_user_model.dart';
import 'package:shop_app/modules/social_app/social_register/cubit/register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userSocialRegister({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userSocialCreate(
        email: email,
        password: password,
        name: name!,
        phone: phone!,
        uId: value.user!.uid,
      );
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userSocialCreate({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone : phone,
      email : email,
      password : password,
      uId : uId,
      image : 'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?t=st=1652355604~exp=1652356204~hmac=17a1c90ad8f845506f87cb744979486bdc37960bad3afd48c030be04d44b9cec&w=996',
      cover : 'https://img.freepik.com/free-photo/penne-pasta-tomato-sauce-with-chicken-tomatoes-wooden-table_2829-19744.jpg?t=st=1652359497~exp=1652360097~hmac=78b4d26608432e426fb5167a02b3cb8d2d782c101b4efc6eef68c2b0e86813d1&w=996',
      bio : 'write your bio...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool isSecure = true;
  IconData fabIcon = Icons.visibility_off;

  void changePasswordVisibility() {
    isSecure = !isSecure;
    fabIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
