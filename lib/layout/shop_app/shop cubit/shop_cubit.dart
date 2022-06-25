import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/models/shop_app_model/categories_model.dart';
import 'package:shop_app/models/shop_app_model/change_favorites_model.dart';
import 'package:shop_app/models/shop_app_model/get_favorites_model.dart';
import 'package:shop_app/models/shop_app_model/home_model.dart';
import 'package:shop_app/models/shop_app_model/login_model.dart';
import 'package:shop_app/modules/shop_app/cateogries/cateogries.dart';
import 'package:shop_app/modules/shop_app/favourites/favourites.dart';
import 'package:shop_app/modules/shop_app/products/products.dart';
import 'package:shop_app/modules/shop_app/settings/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constacne.dart';
import 'package:shop_app/shared/network/remote.dart';
import '../../../shared/network/end points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomIndexStates());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  Map<int, bool>? favorites = {};

  ShopHomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingStates());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = ShopHomeModel.fromJson(value.data);
      print('home status is ${homeModel!.status}');
      print('old price is ${homeModel!.data?.products![0].oldPrice}');
      homeModel!.data!.products!.forEach((element) {
        favorites!.addAll({
          element.id!: element.favorites!,
        });
      });
      print(favorites.toString());
      emit(HomeSuccessStates());
    }).catchError((error) {
      print("founded one error mostafa ${error.toString()}");
      emit(HomeErrorStates());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
      language: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print("categories name ${categoriesModel!.data!.data[1].name}");
      emit(CategoriesSuccessStates());
    }).catchError((error) {
      print('founded error mostafa in categories ${error.toString()}');
      emit(CategoriesErrorStates());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? id) {
    favorites![id!] = !favorites![id]!;
    emit(ChangeFavoritesSuccessStates());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': id,
      },
    ).then((value) {
      getFavoritesModel();
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (favorites![id] == true) {
        showToast(
          message: changeFavoritesModel!.message!,
          state: ToastStates.success,
        );
        getFavoritesModel();
      }
      print(changeFavoritesModel!.message!);
      emit(ChangeFavoritesSuccessStates());
    }).catchError((error) {
      favorites![id] = !favorites![id]!;
      emit(ChangeFavoritesErrorStates());
    });
  }

  GetFavorites? getFavorites;
  void getFavoritesModel() {
    emit(GetFavoritesLoadingStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
      language: 'en',
    ).then((value) {
      getFavorites = GetFavorites.fromJson(value.data);
      print(
          "name of favorites product ${getFavorites!.data!.data[0].product!.name}");
      emit(GetFavoritesSuccessStates());
    }).catchError((error) {
      print('founded error in get Favorites model mostafa ${error.toString()}');
      emit(GetFavoritesErrorStates());
    });
  }

  ShopUserDataModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
      language: 'en',
    ).then((value) {
      userModel = ShopUserDataModel.fromJson(value.data);
      print("My name is ${userModel!.data!.name}");
      emit(GetUserDataSuccessStates());
    }).catchError((error) {
      emit(GetUserDataErrorStates());
    });
  }

  void updateUserData({
    String? name,
    String? phone,
    String? email,
  }) {
    emit(UpdateUserDataLoadingStates());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, language: 'en', data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      userModel = ShopUserDataModel.fromJson(value.data);
      emit(UpdateUserDataSuccessStates());
    }).catchError((error) {
      showToast(message: userModel!.message!, state: ToastStates.failed);
      emit(UpdateUserDataErrorStates(userModel!));
    });
  }
}
