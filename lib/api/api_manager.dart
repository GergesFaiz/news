import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  /*
   https://newsapi.org/v2/top-headlines/sources?apiKey=500c5a4f9b244f3db92a47f436f1819e
  * */
  static Future<SourceResponse> getSources() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.apiKey,
      });
      var response = await http.get(url);

      // SourceResponse.fromJson(jsonDecode(response.body));
      var bodyString = response.body; //string
      //string =>json
      var json = jsonDecode(bodyString);
      //json=>object
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  /*
  GET https://newsapi.org/v2/everything?q=bitcoin&apiKey=b43d7821ea454ae1a019931358757859
  */
  static Future<NewResponse> getNewsBySourceId(String sourceId) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
          {
        'apiKey':ApiConstants.apiKey,
        'sources': sourceId
      });
      var response = await http.get(url);
      return NewResponse.fromJson(jsonDecode(response.body));
    }
    catch(e) {
    rethrow;
  }

  }
}
