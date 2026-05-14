import 'package:flutter/material.dart';

import 'package:news/api/api_constants.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/source_response.dart';

class SourceViewModel extends ChangeNotifier {
  String? errorMassege;
  List<Source>? sourcesList;


  void getSource(String categoryId) async {
    //todo: reinitialize
    errorMassege=null;
    sourcesList=null;
    notifyListeners();
    try{
      var response = await ApiManager.getSources(categoryId);
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

