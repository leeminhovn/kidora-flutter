import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kidora/src/components/utils/printColor.dart';
import 'package:kidora/src/data/api/endpoint.dart';
import 'package:kidora/src/data/data_source/local/user_local_storge.dart';
import 'package:kidora/src/general/app_constant.dart';

class AppClient {
  late Dio _dio;
  late Dio _dioAuthen;

  final BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstant.baseApiUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: 'application/json');

  AppClient() {
    _dio = Dio(baseOptions);
    _dioAuthen = Dio(baseOptions);
    _dioAuthen.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        printColor.blue(options.path);
        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        
        bool needRecall = false;
        if (response.data['statusCode'] == 403 &&
            UserLocalStorge.store.getString('accessToken') != null) {
              printColor.red('handleCallRefreshToken');
          needRecall = await handleCallRefreshToken(
            UserLocalStorge.store.getString("refreshToken")!,
            UserLocalStorge.store.getString("accessToken")!,
          );
        }

        if (needRecall) {
          printColor.blue('zoooo');
          final String accessToken =
              UserLocalStorge.store.getString('accessToken') ?? "";
          response.requestOptions.headers['Authorization'] =
              "Bearer $accessToken";
          final responseRecall = await _dio.request(
            'https://api.example.com/your-endpoint', // Replace with your API endpoint
            data: response
                .requestOptions.data, // Set the data from the RequestOptions
            options: Options(
              method: response.requestOptions
                  .method, // Set the HTTP method from the RequestOptions
              headers: response.requestOptions
                  .headers, // Set the headers from the RequestOptions
            ),
          );
          printColor.blue(responseRecall.toString());

          return handler.next(responseRecall);
        } else {
          return handler.next(response);
        }
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        // Do something with response error.
        // If you want to resolve the request with some custom data,
        // you can resolve a `Response` object using `handler.resolve(response)`.
        printColor.red(e.error.toString());

        return handler.next(e);
      },
    ));
  }
  Future<bool> handleCallRefreshToken(
      String refreshToken, String accessToken) async {
    try {
      final Response response = await postDioAuth(
          endPoint: Endpoint.urlRefreshToken,
          accessToken: accessToken,
          data: {"refreshToken": refreshToken});

      UserLocalStorge.store
          .setString('refreshToken', response.data['refreshToken']);
      UserLocalStorge.store
          .setString('accessToken', response.data['accessToken']);
      return true;
    } catch (err) {
      UserLocalStorge.store.remove('refreshToken');
      UserLocalStorge.store.remove('accessToken');
      return false;
    }
  }

  Future<Response> getDioAuth(
      {String endPoint = '',
      Map<String, dynamic> queryParameters = const {},
      String accessToken = ''}) {
    _dioAuthen.options.headers["Authorization"] = "Bearer $accessToken";
    return _dioAuthen.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> getDio(
      {String endPoint = '', Map<String, dynamic> queryParameters = const {}}) {
    return _dio.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> postDioAuth(
      {String endPoint = '', String accessToken = '', dynamic data}) {
    _dioAuthen.options.headers["Authorization"] = "Bearer $accessToken";
    return _dioAuthen.post(endPoint, data: jsonEncode(data));
  }

  Future<Response> postDio(String endPoint, {dynamic data}) {
    return _dio.post(endPoint, data: jsonEncode(data));
  }
}
