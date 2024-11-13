import 'package:myhome/data/repository/auth_repository.dart';
import 'package:myhome/data/models/login/login_model.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';
import 'login_signal.dart';

// Este es el servicio que maneja la lógica de login

final authRepository = AuthRepository(authService: ApiService());
// Método para hacer login
Future<void> login(String email, String password) async {
  isLoadingLG.value = true; // Indicamos que está cargando
  isLoginErrorLG.value = false; // Indicamos inicialmente que no hay error
  isLoggedInLG.value = null; // Indicamos inicialmente que es null

  try {
    final result = await authRepository.login(email, password);
    isLoadingLG.value = false; // Detenemos el loading

    if (result is String) {
      loginMessageLG.value = result; // Si es un mensaje de error
      isLoggedInLG.value = false;
    } else if (result is Login) {
      currentUserLG.value = result; // Guardamos el usuario
      isLoggedInLG.value = true; // El usuario ha iniciado sesión correctamente
      loginMessageLG.value = "Login successful";
    }
  } catch (e) {
    isLoginErrorLG.value = true;
    isLoadingLG.value = false;
    loginMessageLG.value = "Error: ${e.toString()}"; // Si ocurre un error
  }
}

// Método para hacer logout
void logout() {
  isLoggedInLG.value = false;
  currentUserLG.value = null;
  loginMessageLG.value = "Logged out successfully";
}
