import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/src/http_interceptors.dart';
import 'http_config.dart';

class HttpManager {
  static String val = '';
  static late Dio _dio;

  //单例模式
  static late final HttpManager _httpManager = HttpManager._internal();
  factory HttpManager.shared() => _httpManager;
  HttpManager._internal() {
    _dio = Dio();
    //全局配置，请求参数和头部处理
    _dio.options = BaseOptions(
      baseUrl: Env.current.baseUrl,
      headers: {'app-name': 'test-app'},
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    );
    //拦截器(这里只进行请求拦截)
    _dio.interceptors.add(RequestInterceptor());
    //TODO: 这里加个日志拦截器专门对日志进行处理
    //TODO: 或者把token刷新的逻辑提取出来，专门的token刷新机制进行处理
    //但是要确定拦截器是并发的还是顺序执行的
  }
  Future<Map<String, dynamic>?> request(
    String path, {
    String? method,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
          extra: extra,
        ),
      );
      //TODO：日志记录
      //这里对响应进行处理
      return _handleResponse(response);
    } on DioException catch (e) {
      //异常处理
      return _handleException(e);
    }
  }

  Future<Map<String, dynamic>?> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic>? response = await request(
      path,
      data: data,
      queryParameters: queryParameters,
      method: 'GET',
      extra: extra,
      headers: headers,
    );
    return response;
  }

  Future<Map<String, dynamic>?> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic>? response = await request(
      path,
      data: data,
      queryParameters: queryParameters,
      method: 'POST',
      extra: extra,
      headers: headers,
    );
    return response;
  }

  Future<Map<String, dynamic>?> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic>? response = await request(
      path,
      data: data,
      queryParameters: queryParameters,
      method: 'PUT',
      extra: extra,
      headers: headers,
    );
    return response;
  }

  Future<Map<String, dynamic>?> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic>? response = await request(
      path,
      data: data,
      queryParameters: queryParameters,
      method: 'DElETE',
      extra: extra,
      headers: headers,
    );
    return response;
  }

  ///处理请求结果
  //这一步可以在onResponse拦截进行预处理，看着办。
  Map<String, dynamic>? _handleResponse(Response response) {
    dynamic responseData;
    //用户只对data字段感兴趣
    if (response.data != null &&
        response.data is Map &&
        response.data['data'] != null) {
      responseData = response.data['data'];
      //如果这里有服务端自定义的错误码如response.data['code'];
      //可以依据code进行业务层的错误处理
    }
    return responseData;
  }

  ///处理异常
  Map<String, dynamic>? _handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        //连接超时处理
        break;
      case DioExceptionType.sendTimeout:
        //发送超时处理
        break;
      case DioExceptionType.receiveTimeout:
        //接收超时处理
        break;
      case DioExceptionType.badResponse:
        //服务器响应错误处理处理
        break;
      case DioExceptionType.cancel:
        //请求取消处理
        break;
      case DioExceptionType.connectionError:
        //连接错误处理
        break;
      case DioExceptionType.unknown:
      default:
      //未知错误
    }
    return null;
  }
}
