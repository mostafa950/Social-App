import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textButton(
      text: 'logout',
      onPressed: (){
        navigateToFinish(context, SocialLoginScreen());
      },
    );
  }
}
