import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_clean_archi/providers/http_client/http_client.dart';

class HttpRequest {
  // final String _baseUrl = "http://10.0.2.2:8000/";
  final String _baseUrl = "http://192.168.1.90:8000/";
  final String path;
  final Dio _client = createHttpClient();
  final Map? data;

  HttpRequest({required this.path, this.data});

  Future<dynamic> get({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      final response = await _client.get(_baseUrl + path);
      if (onSuccess != null) return onSuccess(response);
    } on DioError catch (error) {
      if (onError != null) return onError(error);
    }
  }

  Future<dynamic> post({
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      var response = await _client.post(_baseUrl + path, data: data);
      if (onSuccess != null) return onSuccess(response);
    } on DioError catch (error) {
      if (onError != null) return onError(error);
    }
  }
}
