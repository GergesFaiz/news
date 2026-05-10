import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news/api/Dio/dio_interceptor.dart';
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManager {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org',
      // queryParameters: {'apiKey': ApiConstants.apiKey},
      headers: {'x-apiKey': ApiConstants.apiKey},
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  DioManager() {
    dio.interceptors.add(DioInterceptor());
    dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
            enabled: kDebugMode,
            filter: (options, args){
              // don't print requests with uris containing '/posts'
              if(options.path.contains('/posts')){
                return false;
              }
              // don't print responses with unit8 list data
              return !args.isResponse || !args.hasUint8ListData;
            }
        )
    );

    }

  Future<SourceResponse> getSources(String categoryId) async {
    try {
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines/sources',
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          'category': categoryId,
        },
      );
      return SourceResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<NewResponse> getNewsBySourceId(String sourceId) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {'apiKey': ApiConstants.apiKey, 'sources': sourceId},
      );

      return NewResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<News>> searchNews(String query, {int page = 1}) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          'q': query,
          'sortBy': 'publishedAt',
          'pageSize': '20',
          'page': page.toString(),
        },
      );

      final newResponse = NewResponse.fromJson(response.data);

      if (newResponse.status != 'ok') {
        throw Exception(newResponse.message ?? 'Unknown error');
      }
      return newResponse.articles ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
