import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/social_app/cubit/social_state.dart';
import 'package:shop_app/models/social_app_model/message_model.dart';
import 'package:shop_app/models/social_app_model/post_model.dart';
import 'package:shop_app/models/social_app_model/social_user_model.dart';
import 'package:shop_app/modules/social_app/chats/chats_screen.dart';
import 'package:shop_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:shop_app/modules/social_app/new_post/new_posts_screen.dart';
import 'package:shop_app/modules/social_app/settings/settings_screen.dart';
import 'package:shop_app/modules/social_app/users/users_screen.dart';
import 'package:shop_app/shared/components/constacne.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialGetUserInitialState());
  // attribute == member
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserDataSocial() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

// Shimmer   card_loading: ^0.1.5 width: MediaQuery.of(context).size.width,
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];
  int currentIndex = 0;
  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostsStates());
    }
    if (index == 1) {
      getAllUser();
      currentIndex = index;
      emit(SocialChangeBottomNavStates());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavStates());
    }
  }

  File? imageProfile;
  var picker = ImagePicker();
  Future getImageProfile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProfile = File(pickedFile.path);
      emit(SocialImageProfilePickedSuccessState());
    } else {
      print('no photos selected.');
      emit(SocialImageProfilePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/ ${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, profile: value);
        print(value);
        emit(SocialUploadImageProfileSuccessState());
      }).catchError((error) {
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageProfileErrorState());
    });
  }

  File? imageCover;
  var pickerCover = ImagePicker();
  Future getImageCover() async {
    final pickedFile = await pickerCover.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageCover = File(pickedFile.path);
      emit(SocialImageCoverPickedSuccessState());
    } else {
      print('no photos selected.');
      emit(SocialImageCoverPickedErrorState());
    }
  }

  void uploadCoverImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/ ${Uri.file(imageCover!.path).pathSegments.last}')
        .putFile(imageCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
        print(value);
        emit(SocialUploadImageCoverSuccessState());
      }).catchError((error) {
        emit(SocialUploadImageCoverErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageCoverErrorState());
    });
  }

  void updateUserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? profile,
    String? cover,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profile ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      password: userModel!.password,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserDataSocial();
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;
  var pickedPostImage = ImagePicker();
  Future getPostImage() async {
    final pickedFile =
        await pickedPostImage.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialImagePostPickedSuccessState());
    } else {
      print('no photos selected.');
      emit(SocialImagePostPickedErrorState());
    }
  }

  void uploadPostImage({
    @required String? text,
    @required String? dateTime,
  }) {
    emit(SocialCreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/ ${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
          dateTime: dateTime,
          text: text,
          imageOfPost: value,
        );
        print(value);
        emit(SocialCreateNewPostSuccessState());
      }).catchError((error) {
        emit(SocialCreateNewPostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void createNewPost({
    @required String? dateTime,
    @required String? text,
    String? imageOfPost,
  }) {
    emit(SocialCreateNewPostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      imageProfile: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: imageOfPost ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  var numOfLikes;
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          numOfLikes = value.docs.length;
          print("value docs length ${value.docs.length}");
          this.postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
        emit(SocialGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost(index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId[index])
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      //getPosts();
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  /*void likesLength(index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId[index])
        .collection('likes')
        .get()
        .then((value) {
      numOfLikes = value.docs.length;
      // getPosts();
      print("vvvvvvvvvvvvvvvvvvvvvvvvvvv ${numOfLikes = value.docs.length}");
    }).catchError((error) {});
  }*/

  bool likeClick = false;

  void changeLikeOfPost(context, index) {
    likeClick = !likeClick;
    if (likeClick) {
      likePost(index);
      numOfLikes++;
      //getPosts();
    } else {
      numOfLikes = numOfLikes - 1;
      //getPosts();
    }
    emit(SocialChangeLikeClickState());
  }

  List<SocialUserModel> users = [];
  void getAllUser() {
    emit(SocialGetAllUserLoadingState());
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
            print("users length is : ${users.length}");
            emit(SocialGetAllUserSuccessState());
          }
        });
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    @required String? receivedId,
    @required String? dateTime,
    @required String? text,
  }) {
    SocialMessageModel model = SocialMessageModel(
      text: text,
      dateTime: dateTime,
      receivedId: receivedId,
      senderId: userModel!.uId,
    );

    if (text != '') {
      // all my chats
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .collection('chats')
          .doc(receivedId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialMessageSendSuccessState());
      }).catchError((error) {
        emit(SocialMessageSendErrorState(error.toString()));
      });

      // all receiver chats
      FirebaseFirestore.instance
          .collection('users')
          .doc(receivedId)
          .collection('chats')
          .doc(userModel!.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialMessageSendSuccessState());
      }).catchError((error) {
        emit(SocialMessageSendErrorState(error.toString()));
      });
    }
  }

  List<SocialMessageModel> messages = [];
  void getMessages({
    @required String? receivedId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receivedId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(SocialMessageModel.fromJson(element.data()));
        emit(SocialGetMessageSuccessState());
      });
    });
  }
}
