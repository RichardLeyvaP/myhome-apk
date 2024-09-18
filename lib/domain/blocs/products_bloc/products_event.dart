import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/products/product_model.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

// Evento para solicitar las tareas por fecha
class ProductsRequested extends ProductsEvent {
  const ProductsRequested();

  @override
  List<Object> get props => [];
}

// Evento para enviar la tarea final
class ProductSubmitted extends ProductsEvent {
  final ProductElement productElement;

  const ProductSubmitted(this.productElement);

  @override
  List<Object> get props => [productElement];
}

// Evento para enviar la tarea final
class ProductUpdated extends ProductsEvent {
  final ProductElement productElement;

  const ProductUpdated(this.productElement);

  @override
  List<Object> get props => [productElement];
}
