import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/domain/blocs/tasks/tasks_signal.dart';

class TaskService {
  final TasksRepository tasksRepository;

  TaskService({required this.tasksRepository});

  // Solicitar tareas por fecha
  Future<void> fetchTasks(String date) async {
    isLoading.value = true;
    try {
      final result = await tasksRepository.getTasks(date);
      isLoading.value = false;
      if (result is String) {
        errorMessage.value = result;
        taskData.value = null;
      } else if (result is Task) {
        taskData.value = result;
      }
    } catch (error) {
      isLoading.value = false;
      errorMessage.value = "Error: ${error.toString()}";
    }
  }

  // Actualizar título y descripción de la tarea
  void updateTaskTitleDescription(String title, String description) {
    taskElement.value = taskElement.value.copyWith(title: title, description: description);
  }

  // Actualizar prioridad de la tarea
  void updateTaskPriority(int priorityId) {
    taskElement.value = taskElement.value.copyWith(priorityId: priorityId);
  }

  // Actualizar familiares asignados a la tarea
  void updateTaskFamily(List<Person> familyMembers) {
    taskElement.value = taskElement.value.copyWith(people: familyMembers);
  }

  // Enviar tarea actualizada
  Future<void> submitTask() async {
    isLoading.value = true;
    try {
      await tasksRepository.addTasks(taskElement.value);
      successMessage.value = "Task submitted successfully!";
    } catch (error) {
      successMessage.value = "Error submitting task: ${error.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
