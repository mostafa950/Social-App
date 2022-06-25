import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/models/shop_app_model/get_favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (ShopCubit.get(context).getFavorites != null && ShopCubit.get(context).getFavorites!.data!.data.length != 0) {
          return conditionalBuilder(
            condition: true,
            builder: (ShopCubit.get(context).getFavorites != null &&
                    ShopCubit.get(context).getFavorites!.data!.data != 0 &&
                    ShopCubit.get(context).categoriesModel != null &&
                    ShopCubit.get(context).homeModel != null &&
                    state is! GetFavoritesLoadingStates)
                ? ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => favoritesItem(
                        ShopCubit.get(context).getFavorites, index, context),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount:
                        ShopCubit.get(context).getFavorites!.data!.data.length,
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget favoritesItem(GetFavorites? model, index, context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image:
                    NetworkImage('${model!.data!.data[index].product!.image}'),
                height: 120,
                width: 120,
              ),
              if (model.data!.data[index].product!.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 120,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.data!.data[index].product!.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13.0,
                    height: 0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.data!.data[index].product!.price.toString()}\$",
                      style: TextStyle(
                        fontSize: 10.0,
                        height: 0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.data!.data[index].product!.discount != 0)
                      Text(
                        "${model.data!.data[index].product!.old_price.toString()}",
                        style: TextStyle(
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(
                            model.data!.data[index].product!.productId);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites![
                                model.data!.data[index].product!.productId]!
                            ? Colors.blue
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
