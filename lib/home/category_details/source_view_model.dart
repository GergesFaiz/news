import 'package:flutter/material.dart';

import 'package:news/api/api_constants.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/sources/data_source/remote/impl/source_remote_data_source_impl.dart';
import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/impl/source_repository_impl.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/model/source_response.dart';

class SourceViewModel extends ChangeNotifier {
  String? errorMassege;
  List<Source>? sourcesList;
  SourceRepository sourceRepository;

  SourceViewModel({required this.sourceRepository});

  void getSource(String categoryId) async {
    //todo: reinitialize
    errorMassege=null;
    sourcesList=null;
    notifyListeners();
    try{
      var response = await sourceRepository.getSources(categoryId);
      if(response.status=='error'){
        errorMassege=response.message;
      }else{
        sourcesList=response.sources;

      }
    }catch(e){
      errorMassege=e.toString();
    }
    notifyListeners();

  }
}

