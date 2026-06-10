import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/news/data_source/remote/impl/news_remote_data_source_impl.dart';
import 'package:news/data/repository/news/data_source/remote/news_remote_data_source.dart';
import 'package:news/data/repository/news/repository/impl/news_repository_impl.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/model/news_response.dart';

class NewsViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;

  NewsRepository newsRepository;

  NewsViewModel({required this.newsRepository});

  void getNewsBySourceId(String sourceId) async {
    try {
      var response = await newsRepository.getNewsBySourceId(sourceId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        newsList = response.articles!;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
