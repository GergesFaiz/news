import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/news/data_source/remote/news_remote_data_source.dart';
import 'package:news/model/news_response.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewResponse> getNewsBySourceId(String sourceId) async {
    var response = await apiManager.getNewsBySourceId(sourceId);
    return response;
  }
}
