import 'package:signals/signals.dart';
import 'package:myhome/data/models/login/login_model.dart';

// Definimos las señales
final Signal<bool> isLoggedIn = Signal<bool>(false);
final Signal<String> loginMessage = Signal<String>(""); // Mensaje de error o éxito
final Signal<Login?> currentUser = Signal<Login?>(null); // Usuario actual
final Signal<bool> isLoading = Signal<bool>(false); // Estado de carga
