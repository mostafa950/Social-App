import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app_model/search_model.dart';
import 'package:shop_app/modules/shop_app/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/constacne.dart';
import 'package:shop_app/shared/network/end%20points.dart';
import 'package:shop_app/shared/network/remote.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String? text) {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text' : text!,
      },
      language: 'en',
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      printFullText(searchModel.toString());
      print("total in search ${searchModel!.data!.total}");
      emit(SearchSuccessStates());
    }).catchError((error){
      print('Founded error in search mostafa ${error.toString()}');
      emit(SearchErrorStates());
    });
  }
}
