import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/repository/sources/data_source/local/impl/source_local_data_source_impl.dart';
import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourceRemoteDataSource remoteDataSource;
  SourceLocalDataSource localDataSource;

  SourceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<SourceResponse> getSources(String categoryId) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //todo:  internet => online
      var sourceResponse = await remoteDataSource.getSources(categoryId);
      localDataSource.saveSources(sourceResponse);
      return sourceResponse;
    } else {
      //todo: no internet => offline
      var sourceResponse = await localDataSource.getSources(categoryId);
      return sourceResponse;
    }
  }
}
