import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/social_layout.dart';
import 'package:shop_app/modules/shop_app/Login/login%20cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_app/Login/login%20cubit/login_state.dart';
import 'package:shop_app/modules/shop_app/Login/login_screen.dart';
import 'package:shop_app/modules/shop_app/on_borading/onborading.dart';
import 'package:shop_app/modules/shop_app/registger/register%20cubit/register_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end%20points.dart';
import 'package:shop_app/shared/network/local.dart';
import 'package:shop_app/shared/network/remote.dart';
import 'package:shop_app/shared/styles/bloc_observer.dart';

import 'layout/shop_app/shop_layout.dart';
import 'modules/social_app/social_login/login_screen.dart';
import 'shared/components/constacne.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print(message.data.toString());
  showToast(message: 'on message background', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await CacheHelper.initial();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget widget;
/*  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else {
      widget = LoginScreen();
    }
     }
   else {
     widget = OnBoarding();
   }*/
  print("onBoarding is $onBoarding");
  // print("token is $token");
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  var tokenMessage = await FirebaseMessaging.instance.getToken();

  print("token message is ${tokenMessage}");

  // fcm on foreground
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(message: 'on message', state: ToastStates.success);
  });
  // fcm on notifications on opened app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(message: 'on message opened app', state: ToastStates.success);
  });
  // fcm on notifications on background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.dioInitial();
  runApp(MyApp(widget));
}
// https://app.getpostman.com/join-team?invite_code=23559ed437c2a02c947d9a07dadd60f4
// flutter run -d chrome --web-renderer html    for run app in web
// flutter create --platforms=windows .   for create windows desktop
// flutter run -d windows          for run app in desktop
class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesModel()
            ..getUserData(),
        ),
        BlocProvider(create: (context) => ShopLoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserDataSocial()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<ShopLoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widget,
          );
        },
      ),
    );
  }
}
