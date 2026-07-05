import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio get dio => _dio;
}
