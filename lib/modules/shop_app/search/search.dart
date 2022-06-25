import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app_model/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../../layout/shop_app/shop cubit/shop_cubit.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var _formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormedFailed(
                      prefixIcon: Icons.search,
                      name: 'search',
                      type: TextInputType.text,
                      onTap: () {},
                      controller: searchController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'this filed is required';
                        }
                        return null;
                      },
                      onSubmit: (value) {
                        SearchCubit.get(context).search(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => searchItem(
                              SearchCubit.get(context).searchModel,
                              index,
                              context),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .total!,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItem(SearchModel? model, index, context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model!.data!.data[index].image}'),
                height: 120,
                width: 120,
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
                  "${model.data!.data[index].name}",
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
                      "${model.data!.data[index].price.toString()}\$",
                      style: TextStyle(
                        fontSize: 10.0,
                        height: 0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(model.data!.data[index].productId);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context)
                                .favorites![model.data!.data[index].productId]!
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

// ./gradlew signingReport