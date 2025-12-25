// main.dart
// import 'package:dio/dio.dart';
import 'core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/session/session_manager.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
// import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'app_startup.dart';

// main.dart - Updated version
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print('Starting app initialization...');

    final sessionManager = SessionManager();

    // 1️⃣ Create Dio instance
    final dio = DioClient.dio;

    // 2️⃣ Create Remote Data Source (IMPLEMENTATION)
    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);

    // 3️⃣ Create Repository
    final AuthRepository authRepository =
        AuthRepositoryImpl(authRemoteDataSource);

    print('Running app...');
    runApp(
      MyApp(
        sessionManager: sessionManager,
        authRepository: authRepository,
      ),
    );
  } catch (e, stackTrace) {
    print('Error during initialization: $e');
    print('Stack trace: $stackTrace');

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization Error: $e'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final SessionManager sessionManager;
  final AuthRepository authRepository;

  const MyApp({
    super.key,
    required this.sessionManager,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    final loginUseCase = LoginUseCase(authRepository);
    // final signupUseCase = SignupUseCase(authRepository);

    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
        loginUseCase: loginUseCase,
        // signupUseCase: signupUseCase,
        sessionManager: sessionManager,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StockSync IMS',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AppStartup(
          sessionManager: sessionManager,
        ), // Pass sessionManager here
      ),
    );
  }
}
