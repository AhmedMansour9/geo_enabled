import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geo_enabled/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:geo_enabled/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor? loggingInterceptor;
  final SharedPreferences? sharedPreferences;

  late Dio dio;
  String? token;

  DioClient(
    this.baseUrl,
    Dio dioC, {
    this.loggingInterceptor,
    this.sharedPreferences,
  }) {
    token = sharedPreferences?.getString(AppConstants.TOKEN);
    print(token);
    dio = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 2)
      ..options.receiveTimeout = const Duration(minutes: 2)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'api_key': 'AAAAB3NzaC1yc2EAAAADAQABAAABgQDF0x2PWZ+e12EBc+tg5gwqENN35YwaAg+IvEGdDkOIcPXJsgPGy+A9Ta0byftU7+2ZL4O0XzuX0oYqDIGwlf+EaTOKUbDh99YUnpK2k7ypT0gvPFf1qFeZORgLl46j53QoPpZbMKiGxWxJaJEPU7GAHKaJzu9HZ7u2B/e5CYQcs7hvyoi56kVNKwhR/grGNpuB+ci0rtkxs7xMSn+3fAcGE7CNEK1mZtZ1JwMoebA5YX9v5pNl3ns0/wqybk+OBnLiwMzu8GnY6N4GPc39vfVDcG8mHyxU3KUzfE+BO5oyUd2BLNq0xAllpTeg9576+Vj3QoW35NEjijChF71vttBtgGgLG1sHGQXa1Efg/dDn9BIw0wRMlP1/tJ4ue8gD5ahOt71NcYV/s/Oda0WZa8pEWwonyxT7tPeTKx4Gu5ar2pVXxMQ8vIRQMqBRh31gCKXqGP8siDgNXFbrkjIe7xmNFsvu5DBnk4GhRndWMY7J3fnac5uA7XHHcxEtcDC0PZ0='
      };
    dio.interceptors.add(loggingInterceptor!);
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
