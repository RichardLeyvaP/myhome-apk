import 'package:flutter/material.dart';
import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_signal.dart';
import 'package:myhome/domain/modelos/category_model.dart';

class CategoriesService {
  final TasksRepository tasksRepository;

  CategoriesService({required this.tasksRepository});

  // Método para solicitar categorías, prioridades y otras informaciones
  Future<void> fetchCategoriesStatusPriority() async {
    isLoading.value = true; // Indicamos que está cargando
    try {
      final jsonResponse = await tasksRepository.getCategoriesStatusPriority();

      // Mapeamos los resultados y los actualizamos en las señales
      List<Category> categoriesList = (jsonResponse['taskcategories'] as List<dynamic>).map((categoryJson) {
        return Category(
          title: categoryJson['nameCategory'],
          icon: _getCategoryIcon(categoryJson['nameCategory']),
          id: categoryJson['id'],
        );
      }).toList();

      List<Status> statusList = (jsonResponse['taskstatus'] as List<dynamic>).map((statusJson) {
        return Status(
          title: statusJson['nameStatus'],
          icon: _getCategoryIcon(statusJson['nameStatus']),
          id: statusJson['id'],
        );
      }).toList();

      List<Priority> prioritiesList = (jsonResponse['taskpriorities'] as List<dynamic>).map((priorityJson) {
        return Priority(
          title: priorityJson['namePriority'],
          description: priorityJson['descriptionPriority'],
          id: priorityJson['id'],
        );
      }).toList();

      List<Taskperson> taskpersonList = (jsonResponse['taskpeople'] as List<dynamic>).map((personJson) {
        return Taskperson(
          id: personJson['id'],
          imagePerson: personJson['imagePerson'],
          rolId: personJson['rolId'],
          namePerson: personJson['namePerson'],
          nameRole: personJson['nameRole'],
        );
      }).toList();

      List<int> taskPersonIds = taskpersonList.map((person) => person.id).toList();
      String taskRecurrence = jsonResponse['taskrecurrences'][0]; // Ejemplo

      // Actualizamos las señales con los datos obtenidos
      categories.value = categoriesList;
      status.value = statusList;
      priorities.value = prioritiesList;
      taskPersons.value = taskpersonList;
      selectedPersonIds.value = taskPersonIds;
      frequencyTask.value = taskRecurrence;

      isLoading.value = false; // Detenemos el loading
    } catch (error) {
      isLoading.value = false;
      errorMessage.value = "Error: ${error.toString()}"; // Si ocurre un error
    }
  }

  // Método auxiliar para asignar íconos según el nombre de la categoría (puedes personalizar esto)
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'cleaning':
        return Icons.cleaning_services;
      case 'electronics':
        return Icons.electrical_services;
      default:
        return Icons.category; // Un ícono genérico si no coincide
    }
  }

  void onPrioritySelected(int priorityId) {
    selectedPriorityId.value = priorityId;
  }

  void onCategorySelected(int categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void onTaskStateSelected(int stateTaskId) {
    selectStateTask.value = stateTaskId;
  }

  void onPersonSelected(int personId) {
    final updatedPersonIds = List<int>.from(selectedPersonIds.value)..add(personId);
    selectedPersonIds.value = updatedPersonIds;
  }

  void onFrequencyChanged(String newFrequency) {
    frequencyTask.value = newFrequency;
  }
}
