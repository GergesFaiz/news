import 'package:news/model/news_response.dart';

abstract class NewsRemoteDataSource {
  Future<NewResponse> getNewsBySourceId(String sourceId);
}
