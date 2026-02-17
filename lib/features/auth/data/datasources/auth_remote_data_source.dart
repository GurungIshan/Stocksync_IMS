import 'package:dio/dio.dart';
import 'package:stocksync/features/auth/domain/models/auth_payload.dart';
// import '../../../../core/network/api_response.dart';
// import '../../../../core/network/dio_error_mapper.dart';
import '../models/user_model.dart';
// import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(AuthPayload payload);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(AuthPayload payload) async {
    try {
      final response = await dio.post('/api/Auth/login',
          data: {
            'username': payload.username,
            'password': payload.password,
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
