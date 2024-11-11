import 'package:flutter/material.dart';
import 'package:myhome/data/repository/products_repository.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/product_cat_state_signal.dart';
import 'package:myhome/domain/modelos/category_model.dart'; // Asegúrate de importar tu modelo Category

// Método para cargar las categorías y prioridades
Future<void> loadCategories(ProductsRepository productsRepository) async {
  isLoadingSignal.value = true; // Iniciamos la carga
  isErrorSignal.value = false; // Reseteamos el error

  try {
    final jsonResponse = await productsRepository.getCategoriesPriority();
    List<Category> categories = (jsonResponse['productcategories'] as List<dynamic>).map((categoryJson) {
      return Category(
        title: categoryJson['nameCategory'],
        icon: _getCategoryIcon(categoryJson['nameCategory']),
        id: categoryJson['id'],
      );
    }).toList();

    List<Status> status = (jsonResponse['productstatus'] as List<dynamic>).map((categoryJson) {
      return Status(
        title: categoryJson['nameStatus'],
        icon: _getCategoryIcon(categoryJson['nameStatus']),
        id: categoryJson['id'],
      );
    }).toList();

    // Actualizamos las señales con los datos obtenidos
    categoriesSignal.value = categories;
    statusSignal.value = status;

    isLoadingSignal.value = false; // Finaliza la carga
  } catch (error) {
    isErrorSignal.value = true;
    categoriesErrorSignal.value = error.toString();
    isLoadingSignal.value = false;
  }
}

// Método auxiliar para asignar íconos según el nombre de la categoría
IconData _getCategoryIcon(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case 'food':
      return Icons.fastfood;
    case 'cleaning':
      return Icons.cleaning_services;
    case 'electronics':
      return Icons.electrical_services;
    default:
      return Icons.category;
  }
}

// Funciones para manejar la selección de status y categoría
void selectStatus(int selectedId) {
  selectedStatusIdSignal.value = selectedId;
}

void selectCategory(int selectedCategoryId) {
  selectedCategoryIdSignal.value = selectedCategoryId;
}

void setQuantityProduct(int quantity) {
  quantityProductSignal.value = quantity;
}
