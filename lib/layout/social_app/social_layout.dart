import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/modules/social_app/new_post/new_posts_screen.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';
import '../../shared/components/components.dart';

// to access to SHA1 that belong to app in terminal 1- cd android  2- .\gradlew signingReport
// to access to bundle product identifier in ios 1- click on ios and choose find in and search about product Bundle identifier
// freepik for a high quality
// for words lorem ipsum
class SocialLayout extends StatelessWidget {
  SocialLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostsStates){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leadingWidth: 1,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: GoogleFonts.pacifico(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(icon : Icon(IconBroken.Notification,color: Colors.black), onPressed: (){},),
              IconButton(icon : Icon(IconBroken.Search,color: Colors.black), onPressed: (){},),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Upload,
                ),
                label: 'post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'location',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'settings',
              ),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            elevation: 20,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}

Widget emailVerified() {
  return (!FirebaseAuth.instance.currentUser!.emailVerified)
      ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(5),
            color: Colors.amber.withOpacity(0.5),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Please verify your email'),
              Spacer(),
              textButton(
                  text: 'send',
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!
                        .sendEmailVerification()
                        .then((value) {
                      showToast(
                          message: 'check your mail',
                          state: ToastStates.success);
                    }).catchError((error) {});
                  }),
            ],
          ),
        )
      : Center(child: CircularProgressIndicator());
}
