import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: '',
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}

//http://10.0.2.2:5000

// https://192.168.1.5:7232
