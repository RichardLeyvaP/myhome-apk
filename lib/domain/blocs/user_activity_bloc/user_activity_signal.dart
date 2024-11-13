import 'package:signals/signals.dart';

// Definición de las señales
final Signal<String> currentScreen = Signal<String>(""); // Nombre de la pantalla actual
final Signal<String?> actionDescription = Signal<String?>(null); // Descripción de la acción realizada
final Signal<String?> selectedItemTitle = Signal<String?>(null); // Título del elemento seleccionado
final Signal<String> dataField = Signal<String>(""); // Campo de entrada de datos
final Signal<String> dataType = Signal<String>(""); // Tipo de entrada de datos
final Signal<dynamic> dataValue = Signal<dynamic>(null); // Valor de entrada de datos
final Signal<String?> errorDescription = Signal<String?>(null); // Descripción del error
final Signal<String?> errorContext = Signal<String?>(null); // Contexto del error
final Signal<DateTime?> sessionStart = Signal<DateTime?>(null); // Inicio de sesión
final Signal<DateTime?> sessionEnd = Signal<DateTime?>(null); // Fin de sesión
final Signal<Duration?> sessionDuration = Signal<Duration?>(null); // Duración de la sesión
