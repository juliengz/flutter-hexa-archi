import 'dart:async';

import 'package:dio/dio.dart';

const noData = "n/a";

class HTTPRequestLoggingInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print({
      options.method: options.uri,
      "headers": options.headers,
      "Body": options.data ?? noData,
    });

    return handler.next(options);
  }

  @override
  Future onError(DioError err, handler) async {
    print({
      "url": err.response?.realUri,
      "statusCode": err.response?.statusCode,
    });

    return handler.next(err);
  }

  @override
  Future onResponse(response, handler) async {
    print({
      "statusCode": response.statusCode,
      "data": response.data,
    });

    return handler.next(response);
  }
}
