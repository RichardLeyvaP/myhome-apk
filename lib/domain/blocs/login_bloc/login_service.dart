import 'package:myhome/data/repository/auth_repository.dart';
import 'package:myhome/data/models/login/login_model.dart';
import 'login_signal.dart';

// Este es el servicio que maneja la lógica de login
class LoginService {
  final AuthRepository authRepository;

  LoginService({required this.authRepository});

  // Método para hacer login
  Future<void> login(String email, String password) async {
    isLoading.value = true; // Indicamos que está cargando
    try {
      final result = await authRepository.login(email, password);
      isLoading.value = false; // Detenemos el loading

      if (result is String) {
        loginMessage.value = result; // Si es un mensaje de error
        isLoggedIn.value = false;
      } else if (result is Login) {
        currentUser.value = result; // Guardamos el usuario
        isLoggedIn.value = true; // El usuario ha iniciado sesión correctamente
        loginMessage.value = "Login successful";
      }
    } catch (e) {
      isLoading.value = false;
      loginMessage.value = "Error: ${e.toString()}"; // Si ocurre un error
    }
  }

  // Método para hacer logout
  void logout() {
    isLoggedIn.value = false;
    currentUser.value = null;
    loginMessage.value = "Logged out successfully";
  }
}
