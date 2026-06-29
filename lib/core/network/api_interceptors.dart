import 'package:dio/dio.dart';

import '../errors/dio_exception_handler.dart';
import '../utils/logger/app_logger.dart';
import '../utils/snackbar/toast_service.dart';

class AppInterceptor extends Interceptor {
  final String tag;
  final Future<String?> Function()? tokenProvider;

  AppInterceptor({this.tag = 'Dio', this.tokenProvider});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent('Content-Type', () => 'application/json');
    options.headers.putIfAbsent('Accept', () => 'application/json');

    if (tokenProvider != null) {
      final token = await tokenProvider!();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    AppLogger.request(
      client: tag,
      method: options.method,
      uri: options.uri,
      headers: options.headers,
      body: options.data,
      queryParameters: options.queryParameters,
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.response(
      client: tag,
      method: response.requestOptions.method,
      uri: response.requestOptions.uri,
      statusCode: response.statusCode,
      data: response.data,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle and log Dio errors centrally
    final failure = DioExceptionHandler.handle(err);

    AppLogger.httpError(
      client: tag,
      method: err.requestOptions.method,
      uri: err.requestOptions.uri,
      statusCode: err.response?.statusCode,
      data: err.response?.data,
      message: err.message,
    );

    AppLogger.failure(
      failure,
      context:
          'Request: ${err.requestOptions.method} -> ${err.requestOptions.path}',
    );

    if (failure.shouldShowToast) {
      ToastService.showError(failure.message);
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: failure,
      ),
    );
    super.onError(err, handler);
  }
}
