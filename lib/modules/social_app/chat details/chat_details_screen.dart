import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/social_app_model/message_model.dart';
import 'package:shop_app/models/social_app_model/social_user_model.dart';
import 'package:shop_app/modules/social_app/chats/chats_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icons_broken.dart';

import '../../../layout/social_app/cubit/Social_cubit.dart';
import '../../../layout/social_app/cubit/social_state.dart';
import '../../../shared/components/constacne.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? model;
  ChatDetailsScreen({this.model});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receivedId: model!.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  IconBroken.Arrow___Left,
                  color: Colors.black,
                ),
              ),
              elevation: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${model!.image}',
                    ),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${model!.name}',
                    style: GoogleFonts.abel(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              titleSpacing: 0.0,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: conditionalBuilder(
              condition: SocialCubit.get(context).messages.length > 0,
              builder: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var messages =
                              SocialCubit.get(context).messages[index];
                          if (uId == messages.senderId) {
                            return buildSendMessage(messages);
                          } else {
                            return buildReceivedMessage(messages);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Write Your message here...',
                                  border: InputBorder.none,
                                ),
                                controller: messageController,
                                validator: (value) {},
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receivedId: model!.uId,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                              },
                              minWidth: 1,
                              height: 16.0,
                              child: Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Write Your message here...',
                                border: InputBorder.none,
                              ),
                              controller: messageController,
                              validator: (value) {},
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                receivedId: model!.uId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );
                            },
                            minWidth: 1,
                            height: 16.0,
                            child: Icon(
                              IconBroken.Send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildSendMessage(SocialMessageModel messageModel) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            messageModel.text!,
          ),
        ),
      ),
    );
  }

  Widget buildReceivedMessage(SocialMessageModel messageModel) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            messageModel.text!,
          ),
        ),
      ),
    );
  }
}
