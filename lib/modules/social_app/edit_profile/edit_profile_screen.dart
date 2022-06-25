import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var imageProfile = SocialCubit.get(context).imageProfile;
        var imageCover = SocialCubit.get(context).imageCover;
        var cubit = SocialCubit.get(context);
        bioController.text = userModel!.bio!;

        nameController.text = userModel.name!;

        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            title: Text(
              'Edit profile',
              style: GoogleFonts.pacifico(
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              textButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: 'UPDATE',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    if (state is SocialUpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialUpdateUserDataLoadingState)
                      SizedBox(
                        height: 5,
                      ),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(
                                        4.0,
                                      ),
                                      topEnd: Radius.circular(
                                        4.0,
                                      ),
                                    ),
                                    image: DecorationImage(
                                      image: imageCover == null
                                          ? NetworkImage(
                                              '${userModel.cover}',
                                            )
                                          : FileImage(imageCover)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () {
                                      SocialCubit.get(context).getImageCover();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(
                                        IconBroken.Camera,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: imageProfile == null
                                      ? NetworkImage(
                                          '${userModel.image}',
                                        )
                                      : FileImage(imageProfile) as ImageProvider,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    SocialCubit.get(context).getImageProfile();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      IconBroken.Camera,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (cubit.imageProfile != null || cubit.imageCover != null)
                      SizedBox(
                        height: 20,
                      ),
                    if (cubit.imageProfile != null || cubit.imageCover != null)
                      Row(
                        children: [
                          if (cubit.imageProfile != null)
                            Expanded(
                              child: inputButton(
                                text: 'upload profile ',
                                onTap: () {
                                  cubit.uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                height: 40,
                                color: Colors.blue,
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (cubit.imageCover != null)
                            Expanded(
                              child: inputButton(
                                text: 'upload cover ',
                                onTap: () {
                                  cubit.uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                height: 40,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormedFailed(
                      type: TextInputType.text,
                      controller: nameController,
                      name: 'name',
                      prefixIcon: IconBroken.User,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormedFailed(
                      type: TextInputType.text,
                      controller: bioController,
                      name: 'bio',
                      prefixIcon: IconBroken.Info_Circle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextFormedFailed(
                      type: TextInputType.text,
                      controller: phoneController,
                      name: 'phone',
                      prefixIcon: IconBroken.Call,
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
