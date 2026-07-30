import 'package:news/data/repository/sources/data_source/local/source_local_data_source.dart';
import 'package:news/model/source_response.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse> getSources(String categoryId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

  @override
  void saveSources(SourceResponse sourceResponse) {
    // TODO: implement saveSources
  }
}
