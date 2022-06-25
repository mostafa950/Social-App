import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/models/social_app_model/post_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        if (userModel == null) {
          return Center(child: CircularProgressIndicator());
        } else
          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 6.0,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-excited-businessman-dressed-suit_171337-150.jpg?t=st=1648211933~exp=1648212533~hmac=0338dd002942dcbff79135cf4b739ca05c34388192572afa236f31bba3b71026&w=996',
                        ),
                        height: 200,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Text(
                        'Communicate with friends',
                        style: GoogleFonts.lacquer(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                ),
                conditionalBuilder(
                  condition: SocialCubit.get(context).posts.length > 0,
                  builder: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        context, SocialCubit.get(context).posts[index], index),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  fallback: Center(child: CircularProgressIndicator())
                ),
              ],
            ),
          );
      },
    );
  }
}

Widget buildPostItem(context, PostModel model, index) {
  var cubit = SocialCubit.get(context);
  return Card(
    margin: EdgeInsets.all(6.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  '${model.imageProfile}',
                ),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: GoogleFonts.abel(
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.check_circle,
                                  color: Colors.blue, size: 16.0),
                              Spacer(),
                            ],
                          ),
                          Text(
                            '${model.dateTime}',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 0.0,
                                      fontSize: 10,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          if (model.text != null)
            Text(
              '${model.text}',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),

          /*Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#flutter',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(
                    4,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cubit.numOfLikes}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '0',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${cubit.userModel!.image}',
                          ),
                          radius: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'write a comment....',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 0.0,
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // SocialCubit.get(context).likesLength(index);
                    cubit.changeLikeOfPost(context, index);
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'like',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 0.0,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
