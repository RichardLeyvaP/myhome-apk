// Evento para solicitar las categorías y prioridades
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/domain/modelos/category_model.dart';

abstract class CategoriesStatePrioritiesEvent {}

class TaskCategoriesRequested extends CategoriesStatePrioritiesEvent {}

// Estado que manejará las categorías
abstract class CategoriesStatePrioritiesState {}

class CategoriesLoading extends CategoriesStatePrioritiesState {}

class CategoriesStatusPrioritySuccess extends CategoriesStatePrioritiesState {
  final List<Category> categories;
  final List<Status> status;
  final List<Priority> priority;
  final List<dynamic> taskrecurrences;
  final List<Taskperson> taskperson;
  final int? selectedPriorityId;
  final List<int> selectedPersonIds; // Cambia de un único ID a una lista de IDs
  final int? selectedCategoryId;
  final int? selectStatetask;
  final String? frequencytask;

  CategoriesStatusPrioritySuccess(this.categories, this.status, this.priority, this.frequencytask, this.taskrecurrences,
      this.taskperson, this.selectedPersonIds, this.selectedPriorityId, this.selectedCategoryId, this.selectStatetask);
}

class CategoriesFailure extends CategoriesStatePrioritiesState {
  final String error;

  CategoriesFailure(this.error);
}

class SelectedPriorityIdEvent extends CategoriesStatePrioritiesEvent {
  final int selectedPriorityId;

  SelectedPriorityIdEvent(this.selectedPriorityId);
}

class CategoryTaskSelectedEvent extends CategoriesStatePrioritiesEvent {
  final int selectedCategoryId;

  CategoryTaskSelectedEvent(this.selectedCategoryId);
}

class SelectStateEvent extends CategoriesStatePrioritiesEvent {
  final int selectStatetask;

  SelectStateEvent(this.selectStatetask);
}

class FrequencyEvent extends CategoriesStatePrioritiesEvent {
  final String frequencytask;

  FrequencyEvent(this.frequencytask);
}

class PersonEvent extends CategoriesStatePrioritiesEvent {
  final int selectedPersonId;

  PersonEvent(this.selectedPersonId);
}

class CategoriesStatePrioritiesBloc extends Bloc<CategoriesStatePrioritiesEvent, CategoriesStatePrioritiesState> {
  final TasksRepository taskRepository;

  CategoriesStatePrioritiesBloc({required this.taskRepository}) : super(CategoriesLoading()) {
    on<TaskCategoriesRequested>(_onTaskCategoriesRequested);
    on<SelectedPriorityIdEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
          currentState.categories,
          currentState.status,
          currentState.priority,
          currentState.frequencytask,
          currentState.taskrecurrences,
          currentState.taskperson,
          currentState.selectedPersonIds,
          event.selectedPriorityId,
          currentState.selectedCategoryId,
          currentState.selectStatetask,
        ));
      }
    });

    on<CategoryTaskSelectedEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID de categoría seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
          currentState.categories,
          currentState.status,
          currentState.priority,
          currentState.frequencytask,
          currentState.taskrecurrences,
          currentState.taskperson,
          currentState.selectedPersonIds,
          currentState.selectedPriorityId, // Mantiene el selectedPriorityId actual
          event.selectedCategoryId, // Actualizamos el selectedCategoryId aquí
          currentState.selectStatetask,
        ));
      }
    });

    on<SelectStateEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
          currentState.categories,
          currentState.status,
          currentState.priority,
          currentState.frequencytask,
          currentState.taskrecurrences,
          currentState.taskperson,
          currentState.selectedPersonIds,
          currentState.selectedPriorityId, // Mantiene el selectedPriorityId actual
          currentState.selectedCategoryId, // Actualizamos el selectedCategoryId aquí
          event.selectStatetask,
        ));
      }
    });
    on<FrequencyEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
          currentState.categories,
          currentState.status,
          currentState.priority,
          event.frequencytask,
          currentState.taskrecurrences,
          currentState.taskperson,
          currentState.selectedPersonIds,
          currentState.selectedPriorityId, // Mantiene el selectedPriorityId actual
          currentState.selectedCategoryId, // Actualizamos el selectedCategoryId aquí
          currentState.selectStatetask,
        ));
      }
    });
    on<PersonEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Crear una nueva lista con los IDs seleccionados, incluyendo el nuevo ID.
        final updatedSelectedPersonIds = List<int>.from(currentState.selectedPersonIds)..add(event.selectedPersonId);
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
          currentState.categories,
          currentState.status,
          currentState.priority,
          currentState.frequencytask,
          currentState.taskrecurrences,
          currentState.taskperson,
          updatedSelectedPersonIds,
          currentState.selectedPriorityId, // Mantiene el selectedPriorityId actual
          currentState.selectedCategoryId, // Actualizamos el selectedCategoryId aquí
          currentState.selectStatetask,
        ));
      }
    });
  }

  // Método que maneja la lógica de obtener las categorías
  Future<void> _onTaskCategoriesRequested(
      TaskCategoriesRequested event, Emitter<CategoriesStatePrioritiesState> emit) async {
    emit(CategoriesLoading());
    try {
      print('entrando a * - : getCategoriesPriority-1');
      // Llamada al método del repositorio que devuelve categorías y prioridades
      final jsonResponse = await taskRepository.getCategoriesStatusPriority();
      // Mapeamos las categorías que llegan en el JSON a objetos de tipo `Category`
      // Mapea los objetos ProductCP a objetos Category
      print('resultado final entrando a * - : categories:${jsonResponse['productcategories']}');

      // Suponiendo que jsonResponse ya contiene el JSON decodificado
      List<Category> categories = (jsonResponse['taskcategories'] as List<dynamic>).map((categoryJson) {
        return Category(
          title: categoryJson['nameCategory'], // Accede al nombre de la categoría
          icon: _getCategoryIcon(categoryJson['nameCategory']), // Asignar un ícono según el nombre
          id: categoryJson['id'], // Usa el ID real de la categoría
        );
      }).toList();

      List<Status> status = (jsonResponse['taskstatus'] as List<dynamic>).map((categoryJson) {
        return Status(
          title: categoryJson['nameStatus'], // Accede al nombre de la categoría
          icon: _getCategoryIcon(categoryJson['nameStatus']), // Asignar un ícono según el nombre
          id: categoryJson['id'], // Usa el ID real de la categoría
        );
      }).toList();

      List<Priority> priority = (jsonResponse['taskpriorities'] as List<dynamic>).map((categoryJson) {
        return Priority(
          title: categoryJson['namePriority'], // Accede al nombre de la categoría
          description: categoryJson['descriptionPriority'], // Asignar un ícono según el nombre
          id: categoryJson['id'], // Usa el ID real de la categoría
        );
      }).toList();

      List<Taskperson> taskperson = (jsonResponse['taskpeople'] as List<dynamic>).map((categoryJson) {
        return Taskperson(
          id: categoryJson['id'],
          imagePerson: categoryJson['imagePerson'],
          rolId: categoryJson['rolId'],
          namePerson: categoryJson['namePerson'],
          nameRole: categoryJson['nameRole'],
        );
      }).toList();
      final taskrecurrences = jsonResponse['taskrecurrences'];
      print('1-resultado final entrando a * - : categories1:${taskrecurrences}');
      print('1-resultado final entrando a * - : categories2:${taskperson[1].namePerson}');
      print('1-resultado final entrando a * - : categories3:$categories');
      print('1-resultado final entrando a * - : status:${status[0].title}');
      print('1-resultado final entrando a * - : status:${status[0].icon.toString()}');
      final List<int> taskpersonIds = taskperson.map((person) => person.id).toList();

      emit(CategoriesStatusPrioritySuccess(categories, status, priority, taskrecurrences[0], taskrecurrences,
          taskperson, taskpersonIds, priority[0].id, categories[0].id, status[0].id));
    } catch (error) {
      emit(CategoriesFailure(error.toString()));
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
}
