import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static void dioInitial() {
    try {
      dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ));
    } on Exception catch (error) {
      throw Exception('error founded $error');
    }
  }

  static Future<Response> getData({
    required String? url,
    Map<String, dynamic>? query,
    String? language = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': language,
      'Authorization': token?? '',
    };
    return await dio!.get(
      url!,
      queryParameters: query?? null,
    );
  }

  static Future<Response> postData({
    required String? url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? language = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang':  language,
      'Authorization': token,
    };
    return await dio!.post(
      url!,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String? url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? language = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang':  language,
      'Authorization': token,
    };
    return await dio!.put(
      url!,
      data: data,
      queryParameters: query,
    );
  }
}
