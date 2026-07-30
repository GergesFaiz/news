import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/news/data_source/remote/impl/news_remote_data_source_impl.dart';
import 'package:news/data/repository/news/data_source/remote/news_remote_data_source.dart';
import 'package:news/data/repository/news/repository/impl/news_repository_impl.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/data/repository/sources/data_source/local/impl/source_local_data_source_impl.dart';
import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_source/remote/impl/source_remote_data_source_impl.dart';
import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';

SourceRepository injectSourceRepository() {
  return SourceRepositoryImpl(
    localDataSource: injectSourceLocalDataSource(),
    remoteDataSource: injectSourceRemoteDataSource(),
  );
}

SourceRemoteDataSource injectSourceRemoteDataSource() {
  return SourceRemoteDataSourceImpl(apiManager: injectApiManager());
}

SourceLocalDataSource injectSourceLocalDataSource() {
  return SourceLocalDataSourceImpl();
}

ApiManager injectApiManager() {
  return ApiManager();
}

NewsRepository injectNewsRepository() {
  return NewsRepositoryImpl(remoteDataSource: injectNewsRemoteDataSource());
}

NewsRemoteDataSource injectNewsRemoteDataSource() {
  return NewsRemoteDataSourceImpl(apiManager: injectApiManager());
}
