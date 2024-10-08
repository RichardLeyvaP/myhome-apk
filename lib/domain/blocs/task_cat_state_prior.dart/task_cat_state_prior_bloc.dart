// Evento para solicitar las categorías y prioridades
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final int? selectedPriorityId;
  final int? selectedCategoryId;
  final int? selectStatetask;
  final int? frequencytask;

  CategoriesStatusPrioritySuccess(this.categories, this.status, this.priority, this.frequencytask,
      {this.selectedPriorityId, this.selectedCategoryId, this.selectStatetask});
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
  final int frequencytask;

  FrequencyEvent(this.frequencytask);
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
            currentState.categories, currentState.status, currentState.priority, currentState.frequencytask,
            selectedPriorityId: event.selectedPriorityId,
            selectedCategoryId: currentState.selectedCategoryId,
            selectStatetask: currentState.selectStatetask));
      }
    });
    on<CategoryTaskSelectedEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
            currentState.categories, currentState.status, currentState.priority, currentState.frequencytask,
            selectedCategoryId: event.selectedCategoryId,
            selectedPriorityId: currentState.selectedPriorityId,
            selectStatetask: currentState.selectStatetask));
      }
    });
    on<SelectStateEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
            currentState.categories, currentState.status, currentState.priority, currentState.frequencytask,
            selectStatetask: event.selectStatetask,
            selectedPriorityId: currentState.selectedPriorityId,
            selectedCategoryId: currentState.selectedCategoryId));
      }
    });
    on<FrequencyEvent>((event, emit) {
      if (state is CategoriesStatusPrioritySuccess) {
        final currentState = state as CategoriesStatusPrioritySuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusPrioritySuccess(
            currentState.categories, currentState.status, currentState.priority, event.frequencytask,
            selectStatetask: currentState.selectStatetask,
            selectedPriorityId: currentState.selectedPriorityId,
            selectedCategoryId: currentState.selectedCategoryId));
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
      print('1-resultado final entrando a * - : categories:$categories');
      print('1-resultado final entrando a * - : status:${status[0].title}');
      print('1-resultado final entrando a * - : status:${status[0].icon.toString()}');

      emit(CategoriesStatusPrioritySuccess(categories, status, priority, 1));
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
