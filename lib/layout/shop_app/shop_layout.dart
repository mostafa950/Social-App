import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/modules/shop_app/Login/login_screen.dart';
import 'package:shop_app/modules/shop_app/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
              leading: MaterialButton(
                onPressed: () {
                  CacheHelper.removeData(
                    key: 'token',
                  );
                  navigateToFinish(
                    context,
                    LoginScreen(),
                  );
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
              actions: [
                MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    navigateTo(context, SearchScreen(),);
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'settings',
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
