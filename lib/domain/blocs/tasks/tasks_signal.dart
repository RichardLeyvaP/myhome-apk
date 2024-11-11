// signals.dart
import 'package:signals/signals.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';

// Definimos las señales que almacenarán los estados
final Signal<bool> isLoading = Signal<bool>(false);
final Signal<String> errorMessage = Signal<String>("");
final Signal<TaskElement> taskElement = Signal<TaskElement>(const TaskElement());
final Signal<Task?> taskData = Signal<Task?>(null); // Almacena los datos de la tarea
final Signal<String> successMessage = Signal<String>("");
