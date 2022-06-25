import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/shop%20cubit/shop_states.dart';
import 'package:shop_app/models/shop_app_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(ShopCubit.get(context).categoriesModel != null){
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoriesItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
          );
        }
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget categoriesItem(DataModelForCategories model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                2.0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  '${model.image}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.0,
          ),
        ],
      ),
    );
  }
}
