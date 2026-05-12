import 'dart:async';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news/api/Retrofit/model/news/news.dart';
import 'package:news/api/Retrofit/model/news/news_response.dart';
import 'package:news/api/Retrofit/model/source/source_response.dart';
import 'package:news/api/end_points.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi(baseUrl: 'https://newsapi.org')
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) = _RetrofitService;

  @GET(EndPoints.sourceApi)
  Future<SourceResponse> getSources(
    @Query('apiKey') String apiKey,
    @Query('category') String categoryId,
  );

  @GET(EndPoints.newsApi)
  Future<NewsResponse> getNewsBySourceId(
    @Query('apiKey') String apiKey,
    @Query('sources') String sourceId,
  );

  @GET(EndPoints.newsApi)
  Future<NewsResponse> searchNews(
      @Query("apiKey") String apiKey,
      @Query("q") String query,
      @Query("sortBy") String sortBy,
      @Query("pageSize") int pageSize,
      @Query("page") int page,
      );


}
