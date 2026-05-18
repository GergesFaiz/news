import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/news/Cubit/news_state.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel() : super(NewsLoadingState());

  //todo: hold data - handle logic

  void getNewsBySourceId(String sourceId) async {
    try{
      var response = await ApiManager.getNewsBySourceId(sourceId);
      //todo:loading
      emit(NewsLoadingState());
      //todo:error
      if (response.status == 'error') {
        emit(NewsErrorState(errorMessage: 'Something went wrong'));
      }

      //todo:success
      if (response.status == 'ok') {
        emit(NewsSuccessState(newsList: response.articles ?? []));
      }
    }catch(e){
      emit(NewsErrorState(errorMessage: e.toString()));
    }

  }
}
