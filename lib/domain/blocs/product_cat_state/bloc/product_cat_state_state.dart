import 'package:equatable/equatable.dart';
import 'package:myhome/domain/modelos/category_model.dart'; // Asegúrate de importar tu modelo `Category`

// Definimos la clase abstracta de la cual heredan los diferentes estados
abstract class CategoriesPrioritiesState extends Equatable {
  const CategoriesPrioritiesState();

  @override
  List<Object?> get props => [];
}

// Estado inicial de carga
class CategoriesLoading extends CategoriesPrioritiesState {}

// Estado exitoso, cuando ya se tienen las categorías
class CategoriesSuccess extends CategoriesPrioritiesState {
  final List<Category> categories;

  const CategoriesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

// Estado de error
class CategoriesFailure extends CategoriesPrioritiesState {
  final String error;

  const CategoriesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
