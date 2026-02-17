
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../constants/app_constant.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: AppConstant.baseURL,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {'Content-Type': 'application/json'},
          ),
        )
        ..interceptors.add(
          LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: false,
            responseBody: true,
            error: true,
          ),
        )
        ..httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () {
            final client = HttpClient();
            client.badCertificateCallback = (cert, host, port) => true;
            return client;
          },
        );
}
