import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: "https://newsapi.org/",
        headers: {
          "Content_type": "application/json",
        },
      ),
    );
  }

  static Future<Response> getData(String url,
      {Map<String, dynamic>? query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    return await dio.post(url, data: data, queryParameters: query);
  }
}
