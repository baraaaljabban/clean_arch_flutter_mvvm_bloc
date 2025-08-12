import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'connection_checker.dart';

class DioClient {
  final Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 15)
    ..options.receiveTimeout = const Duration(seconds: 15)
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );

  final ConnectionChecker connectionChecker = ConnectionChecker();

  Future<Response<T>> request<T>({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    int? timeoutSeconds,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    // Basic connectivity guard
    if (await connectionChecker.status == NetworkStatus.offline) {
      throw ConnectionUnavailableException();
    }

    dio.options.connectTimeout = Duration(seconds: timeoutSeconds ?? 15);
    dio.options.receiveTimeout = Duration(seconds: timeoutSeconds ?? 15);

    final Options options = Options(method: method, headers: <String, dynamic>{});
    options.headers!.addAll(<String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
    });
    if (headers != null && headers.isNotEmpty) {
      options.headers!.addAll(headers);
    }

    final Response<T> response = await dio.request<T>(
      url,
      data: body,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    final int status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      throw ServerException(statusCode: status, message: response.statusMessage);
    }

    return response;
  }

  Future<Response<dynamic>> getData(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return request<dynamic>(method: 'GET', url: url, queryParameters: queryParameters, headers: headers);
  }
}
