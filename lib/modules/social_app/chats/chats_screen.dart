import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/social_app/cubit/Social_cubit.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/models/social_app_model/social_user_model.dart';
import 'package:shop_app/modules/social_app/chat%20details/chat_details_screen.dart';

import '../../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, index) {},
      builder: (context, index) {
        var cubit = SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildOfItem(cubit.users[index] , context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.users.length,
          ),
        );
      },
    );
  }
}

Widget buildOfItem(SocialUserModel model , context) {
  return InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
            radius: 25,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            '${model.name}',
            style: GoogleFonts.abel(
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
