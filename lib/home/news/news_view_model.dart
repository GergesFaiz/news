import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/news_response.dart';

class NewsViewModel extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;

  void getNewsBySourceId(String sourceId) async {
    try {
      var response = await ApiManager.getNewsBySourceId(sourceId);
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
