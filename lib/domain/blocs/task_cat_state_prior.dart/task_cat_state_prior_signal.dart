import 'package:myhome/domain/modelos/category_model.dart';
import 'package:signals/signals.dart';

// Definir las señales
final Signal<List<Category>> categories = Signal<List<Category>>([]);
final Signal<List<Status>> status = Signal<List<Status>>([]);
final Signal<List<Priority>> priorities = Signal<List<Priority>>([]);
final Signal<List<Taskperson>> taskPersons = Signal<List<Taskperson>>([]);
final Signal<List<int>> selectedPersonIds = Signal<List<int>>([]);
final Signal<int?> selectedCategoryId = Signal<int?>(null);
final Signal<int?> selectedPriorityId = Signal<int?>(null);
final Signal<int?> selectStateTask = Signal<int?>(null);
final Signal<String> frequencyTask = Signal<String>("");
final Signal<bool> isLoading = Signal<bool>(false); // Estado de carga
final Signal<String> errorMessage = Signal<String>(""); // Mensaje de error
