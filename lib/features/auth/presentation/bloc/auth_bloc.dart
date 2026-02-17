import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocksync/features/auth/domain/entities/user.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/session/session_manager.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SessionManager sessionManager;

  AuthBloc({
    required this.loginUseCase,
    required this.sessionManager,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit( AuthLoading());

    try {
      final result = await loginUseCase(
        email: event.email,
        password: event.password,
      );

      // Token handled outside domain
      await sessionManager.saveSession(
        result.email,
        result.name,
        "",
      );
      final user = User(
        email: result.email,
        name: result.name,
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(
        const AuthError('Invalid email or password'),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await sessionManager.clearSession();
    emit(AuthInitial());
  }
}
