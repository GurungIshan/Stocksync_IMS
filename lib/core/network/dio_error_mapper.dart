import 'package:dio/dio.dart';
import '../error/exceptions.dart';

class DioErrorMapper {
  static Exception map(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Connection timeout. Please try again.');
    }

    if (e.response != null) {
      return ServerException(
        e.response?.data['message'] ?? 'Invalid credentials',
      );
    }

    return NetworkException('No internet connection');
  }
}
