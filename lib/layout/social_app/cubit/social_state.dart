abstract class SocialStates {} // parent

class SocialGetUserInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error ;
  SocialGetUserErrorState(this.error);

}

class SocialChangeBottomNavStates extends SocialStates {}

class SocialNewPostsStates extends SocialStates {}

class SocialImageProfilePickedSuccessState extends SocialStates {}

class SocialImageProfilePickedErrorState extends SocialStates {}

class SocialImageCoverPickedSuccessState extends SocialStates {}

class SocialImageCoverPickedErrorState extends SocialStates {}

class SocialImagePostPickedSuccessState extends SocialStates {}

class SocialImagePostPickedErrorState extends SocialStates {}

class SocialUploadImageCoverSuccessState extends SocialStates {}

class SocialUploadImageCoverErrorState extends SocialStates {}

class SocialUploadImageProfileSuccessState extends SocialStates {}

class SocialUploadImageProfileErrorState extends SocialStates {}

class SocialUpdateUserDataErrorState extends SocialStates {}

class SocialUpdateUserDataLoadingState extends SocialStates {}

class SocialCreateNewPostLoadingState extends SocialStates {}

class SocialCreateNewPostSuccessState extends SocialStates {}

class SocialCreateNewPostErrorState extends SocialStates {}

class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

class SocialChangeLikeClickState extends SocialStates {}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error ;
  SocialGetAllUserErrorState(this.error);

}

class SocialMessageSendSuccessState extends SocialStates {}

class SocialMessageSendErrorState extends SocialStates {
  final String error ;
  SocialMessageSendErrorState(this.error);

}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {
  final String error ;
  SocialGetMessageErrorState(this.error);

}



