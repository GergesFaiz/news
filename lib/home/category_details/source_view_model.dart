import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/source_state.dart';
import 'package:news/model/source_response.dart';

class SourceViewModel extends Cubit<SourceState> {
  SourceViewModel() : super(SourceLoadingState());

  //todo: hold data - handle logic

  void getSources(String categoryId) async {
    var response = await ApiManager.getSources(categoryId);
    //todo:loading
    emit(SourceLoadingState());
    //todo:error
    if (response.status == 'error') {
      emit(SourceErrorState(errorMessage: 'Something went wrong'));
    }

    //todo:success
    if (response.status == 'ok') {
      emit(SourceSuccessState(sourcesList: response.sources ?? []));
    }
  }
}
