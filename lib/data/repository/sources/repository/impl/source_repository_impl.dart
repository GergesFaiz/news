import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource remoteDataSource;

  SourceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SourceResponse> getSources(String categoryId) {
    return remoteDataSource.getSources(categoryId);
  }
}
