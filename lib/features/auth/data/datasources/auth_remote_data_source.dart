// import 'package:dio/dio.dart';
// import '../models/user_model.dart';
// import '../../../../core/network/dio_client.dart';

// class AuthRemoteDataSource {
//   final Dio dio = DioClient.dio;

//   Future<UserModel> login(String email, String password) async {
//     try {
//       final response = await dio.post(
//         '',
//         data: {'email': email, 'password': password},
//       );
//       print('🟢 API Response status: ${response.statusCode}');
//       print('🟢 API Response data: ${response.data}');
//       print('🟢 API Response data type: ${response.data.runtimeType}');

//       return UserModel.fromJson(response.data);
//     } on DioException catch (e) {
//       final message = e.response?.data?['message'] ?? 'Login failed';
//       throw Exception(message);
//     }
//   }

//   Future<UserModel> signup(String name, String email, String password) async {
//     try {
//       final response = await dio.post(
//         '/api/Auth/register',
//         data: {'name': name, 'email': email, 'password': password},
//       );

//       return UserModel.fromJson(response.data);
//     } on DioException catch (e) {
//       final message = e.response?.data?['message'] ?? 'Signup failed';
//       throw Exception(message);
//     }
//   }
// }



import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSource {
  final Dio dio = DioClient.dio;

  /// 🔴 Toggle this
  static const bool useMockLogin = true;

  Future<UserModel> login(String email, String password) async {
    if (useMockLogin) {
      return _mockLogin(email);
    }

    try {
      final response = await dio.post(
        '/api/Auth/login',
        data: {'email': email, 'password': password},
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Login failed';
      throw Exception(message);
    }
  }

  Future<UserModel> signup(String name, String email, String password) async {
    if (useMockLogin) {
      return _mockSignup(name, email);
    }

    try {
      final response = await dio.post(
        '/api/Auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Signup failed';
      throw Exception(message);
    }
  }

  // ================= MOCK DATA =================

  Future<UserModel> _mockLogin(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      name: 'Ishan Gurung',
      email: email,
      token: 'mock_token_123',
    );
  }

  Future<UserModel> _mockSignup(String name, String email) async {
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      name: name,
      email: email,
      token: 'mock_token_123',
    );
  }
}

// ///api/Auth/login