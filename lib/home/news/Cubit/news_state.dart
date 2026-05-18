import 'package:news/model/news_response.dart';

abstract class NewsState {} //todo: parent

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {
  String errorMessage;

  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsState {
  List<News> newsList;

  NewsSuccessState({required this.newsList});
}
