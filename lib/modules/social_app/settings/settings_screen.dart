import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
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
                            image: NetworkImage(
                              '${userModel!.cover}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${userModel.image}',
                        ),
                        radius: 55,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${userModel.name}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('100'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('posts'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('10k'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('followers'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('65'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('news'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('100'),
                        SizedBox(
                          height: 8,
                        ),
                        Text('friends'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {},
                    child: Text('add photos'),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditProfileScreen(),
                      //   ),
                      // );
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
