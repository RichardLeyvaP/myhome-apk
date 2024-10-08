import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/repository/products_repository.dart';
import 'package:myhome/domain/modelos/category_model.dart';

// Evento para solicitar las categorías y prioridades
abstract class CategoriesPrioritiesEvent {}

class CategoriesRequested extends CategoriesPrioritiesEvent {}

// Estado que manejará las categorías
abstract class CategoriesPrioritiesState {}

class CategoriesLoading extends CategoriesPrioritiesState {}

class CategoriesStatusSuccess extends CategoriesPrioritiesState {
  final List<Category> categories;
  final List<Status> status;
  final int? selectedStatusId;
  final int? selectedCategoryId;
  final int? quantityProduct;

  CategoriesStatusSuccess(this.categories, this.status,
      {this.selectedStatusId, this.selectedCategoryId, this.quantityProduct});
}

class CategoriesFailure extends CategoriesPrioritiesState {
  final String error;

  CategoriesFailure(this.error);
}

class StatusSelectedEvent extends CategoriesPrioritiesEvent {
  final int selectedId;

  StatusSelectedEvent(this.selectedId);
}

class CategorySelectedEvent extends CategoriesPrioritiesEvent {
  final int selectedCategoryId;

  CategorySelectedEvent(this.selectedCategoryId);
}

class QuantityProductEvent extends CategoriesPrioritiesEvent {
  final int quantityProduct;

  QuantityProductEvent(this.quantityProduct);
}

class PriceProductEvent extends CategoriesPrioritiesEvent {
  final int priceProduct;

  PriceProductEvent(this.priceProduct);
}

class CategoriesPrioritiesBloc extends Bloc<CategoriesPrioritiesEvent, CategoriesPrioritiesState> {
  final ProductsRepository productsRepository;

  CategoriesPrioritiesBloc({required this.productsRepository}) : super(CategoriesLoading()) {
    on<CategoriesRequested>(_onCategoriesRequested);
    on<StatusSelectedEvent>((event, emit) {
      if (state is CategoriesStatusSuccess) {
        final currentState = state as CategoriesStatusSuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusSuccess(currentState.categories, currentState.status,
            selectedStatusId: event.selectedId,
            selectedCategoryId: currentState.selectedCategoryId,
            quantityProduct: currentState.quantityProduct));
      }
    });
    on<CategorySelectedEvent>((event, emit) {
      if (state is CategoriesStatusSuccess) {
        final currentState = state as CategoriesStatusSuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusSuccess(currentState.categories, currentState.status,
            selectedCategoryId: event.selectedCategoryId,
            selectedStatusId: currentState.selectedStatusId,
            quantityProduct: currentState.quantityProduct));
      }
    });
    on<QuantityProductEvent>((event, emit) {
      if (state is CategoriesStatusSuccess) {
        final currentState = state as CategoriesStatusSuccess;
        // Emitimos un nuevo estado con el ID seleccionado actualizado.
        emit(CategoriesStatusSuccess(currentState.categories, currentState.status,
            quantityProduct: event.quantityProduct,
            selectedStatusId: currentState.selectedStatusId,
            selectedCategoryId: currentState.selectedCategoryId));
      }
    });
  }

  // Método que maneja la lógica de obtener las categorías
  Future<void> _onCategoriesRequested(CategoriesRequested event, Emitter<CategoriesPrioritiesState> emit) async {
    emit(CategoriesLoading());
    try {
      print('entrando a * - : getCategoriesPriority-1');
      // Llamada al método del repositorio que devuelve categorías y prioridades
      final jsonResponse = await productsRepository.getCategoriesPriority();
      // Mapeamos las categorías que llegan en el JSON a objetos de tipo `Category`
      // Mapea los objetos ProductCP a objetos Category
      print('resultado final entrando a * - : categories:${jsonResponse['productcategories']}');

      // Suponiendo que jsonResponse ya contiene el JSON decodificado
      List<Category> categories = (jsonResponse['productcategories'] as List<dynamic>).map((categoryJson) {
        return Category(
          title: categoryJson['nameCategory'], // Accede al nombre de la categoría
          icon: _getCategoryIcon(categoryJson['nameCategory']), // Asignar un ícono según el nombre
          id: categoryJson['id'], // Usa el ID real de la categoría
        );
      }).toList();

      List<Status> status = (jsonResponse['productstatus'] as List<dynamic>).map((categoryJson) {
        return Status(
          title: categoryJson['nameStatus'], // Accede al nombre de la categoría
          icon: _getCategoryIcon(categoryJson['nameStatus']), // Asignar un ícono según el nombre
          id: categoryJson['id'], // Usa el ID real de la categoría
        );
      }).toList();
      print('1-resultado final entrando a * - : categories:$categories');
      print('1-resultado final entrando a * - : status:${status[0].title}');
      print('1-resultado final entrando a * - : status:${status[0].icon.toString()}');

      emit(CategoriesStatusSuccess(categories, status));
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
