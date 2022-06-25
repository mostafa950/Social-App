import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/models/shop_app_model/categories_model.dart';
import 'package:shop_app/models/shop_app_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesErrorStates){
          showToast(message: ShopCubit.get(context).changeFavoritesModel!.message!, state: ToastStates.warning);
        }
      },
      builder: (context, state) {
        return conditionalBuilder(
          condition: true,
          builder: (ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null)
              ? productsItems(ShopCubit.get(context).homeModel!,
                  ShopCubit.get(context).categoriesModel!, context)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget productsItems(
      ShopHomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners!
                .map((e) => Image(
                      image: NetworkImage("${e.image}"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => itemCategories(
                        ShopCubit.get(context)
                            .categoriesModel!
                            .data!
                            .data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 5,
                    ),
                    itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1 / 1.7,
                    children: List.generate(
                      model.data!.products!.length,
                      (index) => itemGridProduct(
                          model.data!.products![index], context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemGridProduct(ProductsData model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${model.image}"),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
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
          Text(
            "${model.name}",
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
                "${model.price}\$",
                style: TextStyle(
                  fontSize: 10.0,
                  height: 0,
                  color: defaultColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              if (model.discount != 0)
                Text(
                  "${model.oldPrice}",
                  style: TextStyle(
                    fontSize: 10.0,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeFavorites(model.id);
                },
                icon: CircleAvatar(
                  backgroundColor: ShopCubit.get(context).favorites![model.id]!
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
    );
  }

  Widget itemCategories(DataModelForCategories? data) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 120,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: NetworkImage(
                  "${data!.image}",
                ),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120,
                height: 40,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Text(
                    '${data.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
