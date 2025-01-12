import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  Future<String> getToken() async {
    return 'token';
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    //请求发送前添加逻辑
    options.headers['token'] = await getToken();

    //继续执行请求
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
    // 当访问令牌过期时，受保护的资源会返回401 Unauthorized错误。
    // 此时，客户端需要使用刷新令牌获取新的访问令牌。
    //TODO: token刷新机制
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
