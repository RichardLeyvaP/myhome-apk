import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/products/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// Estado inicial
class ProductInitial extends ProductState {}

// Estado de carga mientras se recuperan las tareas
class ProductLoading extends ProductState {}

// Estado para cuando no hay tareas disponibles
class ProductEmpty extends ProductState {
  final String message;

  const ProductEmpty(this.message);

  @override
  List<Object> get props => [message];
}

// Estado de éxito cuando se recuperan las tareas
class ProductSuccess extends ProductState {
  final Product product;

  const ProductSuccess(this.product);

  @override
  List<Object> get props => [Product];
}

class TaskDataUpdated extends ProductState {
  final String name;
  final String description;

  const TaskDataUpdated({
    required this.name,
    required this.description,
  });
  @override
  List<Object> get props => [name, description];
}

// Estado de error al cargar tareas
class ProductFailure extends ProductState {
  final String error;

  const ProductFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Estado cuando se actualizan los datos de la tarea (como título, descripción, etc.)
class ProductSubmittedUpdated extends ProductState {
  final ProductElement productElement;

  const ProductSubmittedUpdated(this.productElement);

  @override
  List<Object> get props => [productElement];
}

// Estado mientras se envía la tarea a la API
class ProductSubmitting extends ProductState {}

// Estado de éxito cuando se envía la tarea a la API
class ProductSubmittedSuccess extends ProductState {}

// Estado de error al enviar la tarea a la API
class ProductSubmittedFailure extends ProductState {
  final String error;

  const ProductSubmittedFailure({required this.error});

  @override
  List<Object> get props => [error];
}
