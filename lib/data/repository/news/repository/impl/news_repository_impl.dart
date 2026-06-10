import 'package:news/data/repository/news/data_source/remote/news_remote_data_source.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/model/news_response.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NewResponse> getNewsBySourceId(String sourceId) {
    return remoteDataSource.getNewsBySourceId(sourceId);
  }
}
