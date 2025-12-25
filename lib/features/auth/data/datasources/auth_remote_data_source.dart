import 'package:dio/dio.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_error_mapper.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/api/Auth/login',
        data: {'email': email, 'password': password},
      );

      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => UserModel.fromJson(json),
      );

      if (!apiResponse.success) {
        throw ServerException(apiResponse.message);
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    }
  }
}



// import 'package:dio/dio.dart';
// import '../models/user_model.dart';
// import '../../../../core/network/dio_client.dart';

// class AuthRemoteDataSource {
//   final Dio dio = DioClient.dio;

//   static const bool useMockLogin = true;

//   Future<UserModel> login(String email, String password) async {
//     if (useMockLogin) {
//       return _mockLogin(email);
//     }

//     try {
//       final response = await dio.post(
//         '/api/Auth/login',
//         data: {'email': email, 'password': password},
//       );

//       return UserModel.fromJson(response.data);
//     } on DioException catch (e) {
//       final message = e.response?.data?['message'] ?? 'Login failed';
//       throw Exception(message);
//     }
//   }

//   // ================= MOCK DATA =================

//   Future<UserModel> _mockLogin(String email) async {
//     await Future.delayed(const Duration(seconds: 1));

//     return UserModel(
//       name: 'Ishan Gurung',
//       email: email,
//       token: 'mock_token_123',
//     );
//   }
// }

// // ///api/Auth/login
