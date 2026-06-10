import 'package:news/model/news_response.dart';

abstract class NewsRepository {
  Future<NewResponse> getNewsBySourceId(String sourceId);
}
