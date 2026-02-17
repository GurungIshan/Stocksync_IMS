import 'package:stocksync/features/auth/domain/models/auth_payload.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) async {
    try {
      return await remote.login(AuthPayload(username: email, password: password));
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }
}
