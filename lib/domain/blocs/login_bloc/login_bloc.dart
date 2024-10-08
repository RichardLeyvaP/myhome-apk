import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/login/login_model.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:myhome/data/repository/auth_repository.dart'; // Ejemplo del repositorio

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  // Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
  //   emit(LoginLoading());
  //   try {
  //     final result = await authRepository.login(event.email, event.password);

  //     // Puedes agregar lógica aquí para manejar un estado vacío si la API regresa algo inesperado
  //     if (result is String) {
  //       emit(LoginEmpty(result));
  //     } else if (result is Login) {
  //       emit(LoginSuccess(result));
  //     }
  //   } catch (error) {
  //     emit(LoginFailure(error.toString()));
  //   }
  // }
  //
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final result = await authRepository.login(event.email, event.password);

      // Puedes agregar lógica aquí para manejar un estado vacío si la API regresa algo inesperado
      if (result is String) {
        emit(LoginEmpty(result));
      } else if (result is Login) {
        emit(LoginSuccess(result));
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<LoginState> emit) {
    authRepository.logout();
    emit(LoginInitial());
  }
}
