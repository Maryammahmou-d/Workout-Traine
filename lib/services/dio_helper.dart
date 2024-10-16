import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:gym/services/local_storage/cache_helper.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class DioHelper {
  static late Dio dio;
  static late Dio dio2;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://youssefslama.com/api/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
          printErrorHeaders: true,
          printResponseData: true,
          printRequestData: true,
          printErrorData: true,
          printErrorMessage: true,
        ),
      ),
    );
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  static Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    String token = await CacheHelper.getData(key: 'token') ??
        "24|aRWMyLGKqoVUXIZC3dHIkrYUHaVnmT85SCafnn9Gc34bc5bd";
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Response response = await dio.get(
      endpoint,
      data: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.data['message']);
    }
  }

  static Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    FormData? formData,
    String? userToken,
  }) async {
    String? token = userToken ??
        (await CacheHelper.getData(key: 'token') ??
            "24|aRWMyLGKqoVUXIZC3dHIkrYUHaVnmT85SCafnn9Gc34bc5bd");
    if (token != '' || token != null) {
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } else {
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
    }
    try {
      Response response = await dio.post(
        endpoint,
        queryParameters: query,
        data: formData ?? body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception("${e.response?.data['message']}");
    }
  }

  static Future<Response> putData({
    required String endpoint,
    required Map<String, dynamic> body,
  }) {
    dio.options.headers = {
      'Accept': 'application/json',
    };
    return dio.put(
      endpoint,
      data: body,
    );
  }
}
