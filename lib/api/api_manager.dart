import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String categoryId) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.apiKey,
        'category': categoryId,
      });
      var response = await http.get(url);
      return SourceResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewResponse> getNewsBySourceId(String sourceId) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'sources': sourceId,
      });
      var response = await http.get(url);
      return NewResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  // NEW: Search endpoint
  static Future<NewResponse> searchNews(String query) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': '20',
      });
      var response = await http.get(url);
      return NewResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
