import 'package:dio/dio.dart';
import 'package:news/api/api_constants.dart';
class DioInterceptor implements Interceptor{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    print('url:${options.baseUrl}');
    options.headers.addAll({'x-apiKey': ApiConstants.apiKey});
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print('StatusCode:${response.statusCode}');
    handler.next(response);
  }
  
}
//
// class DioInterceptor1 extends QueuedInterceptorsWrapper {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // TODO: implement onRequest
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(
//     Response<dynamic> response,
//     ResponseInterceptorHandler handler,
//   ) {
//     // TODO: implement onResponse
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     super.onError(err, handler);
//   }
// }
