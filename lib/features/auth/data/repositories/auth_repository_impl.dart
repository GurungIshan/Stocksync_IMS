import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) {
    try {
      return remote.login(email, password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User> signup(String name, String email, String password) {
    return remote.signup(name, email, password);
  }
}
