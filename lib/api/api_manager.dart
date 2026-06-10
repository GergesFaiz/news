import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  Future<SourceResponse> getSources(String categoryId) async {
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

  static Future<List<Source>> getSourcesById(String categoryId) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.apiKey,
        'category': categoryId,
      });
      var response = await http.get(url);
      final sourceResponse = SourceResponse.fromJson(jsonDecode(response.body));

      if (sourceResponse.status != 'ok') {
        throw Exception(sourceResponse.message ?? 'Unknown error');
      }
      return sourceResponse.sources ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<NewResponse> getNewsBySourceId(String sourceId) async {
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

  static Future<List<News>> searchNews(String query, {int page = 1}) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': '20',
        'page': '$page',
      });
      var response = await http.get(url);
      final newResponse = NewResponse.fromJson(jsonDecode(response.body));

      if (newResponse.status != 'ok') {
        throw Exception(newResponse.message ?? 'Unknown error');
      }
      return newResponse.articles ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
