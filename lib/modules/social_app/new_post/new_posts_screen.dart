import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:shop_app/modules/social_app/social_login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var timeNow = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            elevation: 0.0,
            actions: [
              textButton(
                text: 'post',
                onPressed: () {
                  if (cubit.postImage == null &&
                      _formKey.currentState!.validate()) {
                    cubit.createNewPost(
                        dateTime: timeNow.toString(),
                        text: textController.text);
                  } else if (
                      cubit.postImage != null) {
                    cubit.uploadPostImage(
                      text: textController.text,
                      dateTime: timeNow.toString(),
                    );
                  }
                  cubit.getPosts();
                },
              ),
            ],
            leading: InkWell(
                child: Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'Create post',
              style: GoogleFonts.pacifico(
                color: Colors.black,
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    if (state is SocialCreateNewPostLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialCreateNewPostLoadingState)
                      SizedBox(
                        width: 10,
                      ),
                    Row(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${cubit.userModel!.image}',
                          ),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${cubit.userModel!.name}',
                          style: GoogleFonts.abel(
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        validator: (value) {
                          if (cubit.postImage == null) {
                            if (value!.isEmpty) {
                              return 'please fill this filed';
                            } else
                              return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'what is in your mind..',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (cubit.postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(4.0),
                              image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                cubit.removePostImage();
                              },
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photos',
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                '#Tags',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
