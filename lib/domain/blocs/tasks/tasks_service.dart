import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';
import 'package:myhome/domain/blocs/tasks/tasks_signal.dart';

final tasksRepository = TasksRepository(authService: ApiService());

// Solicitar tareas por fecha
Future<void> fetchTasks(String date) async {
  taskElementUpdateTA.value = false;
  isLoadingTA.value = true;
  empyMessageTA.value = null;
  errorMessageTA.value = null;
  taskDataTA.value = null;
  try {
    final result = await tasksRepository.getTasks(date);
    if (result is String) {
      empyMessageTA.value = result; //esta vacio
    } else if (result is Task) {
      taskDataTA.value = result; //tiene resultados
    }
  } catch (error) {
    errorMessageTA.value = "Error: ${error.toString()}";
  } finally {
    isLoadingTA.value = false;
  }
}

// Actualizar título y descripción de la tarea
void updateTaskTitleDescription(String title, String description) {
  taskElementTA.value = taskElementTA.value.copyWith(title: title, description: description);
  taskElementUpdateTA.value = true;
}

// Actualizar prioridad de la tarea
void updateTaskPriority(int priorityId) {
  taskElementTA.value = taskElementTA.value.copyWith(priorityId: priorityId);
  taskElementUpdateTA.value = true;
}

// Actualizar familiares asignados a la tarea
void updateTaskFamily(List<Person> familyMembers) {
  taskElementTA.value = taskElementTA.value.copyWith(people: familyMembers);
  taskElementUpdateTA.value = true;
}

// Enviar tarea actualizada
Future<void> submitTask() async {
  isLoadingTA.value = true;
  try {
    await tasksRepository.addTasks(taskElementTA.value);
    successMessageTA.value = "Task submitted successfully!";
  } catch (error) {
    successMessageTA.value = "Error submitting task: ${error.toString()}";
  } finally {
    isLoadingTA.value = false;
  }
}
