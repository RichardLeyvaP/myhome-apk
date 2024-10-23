import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/store/store_model.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

// Evento para solicitar las tiendas por algún criterio (por ejemplo, por fecha)
class StoreRequested extends StoreEvent {
  const StoreRequested();

  @override
  List<Object> get props => [];
}

// Evento para enviar la tienda final
class StoreSubmitted extends StoreEvent {
  final StoreElement storeElement;

  const StoreSubmitted(this.storeElement);

  @override
  List<Object> get props => [storeElement];
}

// Evento para incrementar la cantidad de tiendas (si es necesario en tu lógica)
class IncreaseStoreQuantity extends StoreEvent {}

// Evento para disminuir la cantidad de tiendas
class DecreaseStoreQuantity extends StoreEvent {}

// Evento para actualizar una tienda específica
class StoreUpdated extends StoreEvent {
  final StoreElement storeElement;

  const StoreUpdated(this.storeElement);

  @override
  List<Object> get props => [storeElement];
}
