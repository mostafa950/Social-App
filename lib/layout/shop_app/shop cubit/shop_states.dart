import 'package:shop_app/models/shop_app_model/login_model.dart';

abstract class ShopStates {}

class InitialStates extends ShopStates {}

class ChangeBottomIndexStates extends ShopStates {}

class HomeLoadingStates extends ShopStates {}

class HomeSuccessStates extends ShopStates {}

class HomeErrorStates extends ShopStates {}

class CategoriesLoadingStates extends ShopStates {}

class CategoriesSuccessStates extends ShopStates {}

class CategoriesErrorStates extends ShopStates {}

class ChangeFavoritesSuccessStates extends ShopStates {}

class ChangeFavoritesErrorStates extends ShopStates {}

class GetFavoritesSuccessStates extends ShopStates {}

class GetFavoritesErrorStates extends ShopStates {}

class GetFavoritesLoadingStates extends ShopStates {}

class GetUserDataSuccessStates extends ShopStates {}

class GetUserDataErrorStates extends ShopStates {}

class GetUserDataLoadingStates extends ShopStates {}

class UpdateUserDataSuccessStates extends ShopStates {}

class UpdateUserDataErrorStates extends ShopStates {
  final ShopUserDataModel userModel;

  UpdateUserDataErrorStates(this.userModel);
}

class UpdateUserDataLoadingStates extends ShopStates {}