import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/store/store_model.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

// Estado inicial
class StoreInitial extends StoreState {}

// Estado de carga mientras se recuperan las tiendas
class StoreLoading extends StoreState {}

// Estado para cuando no hay tiendas disponibles
class StoreEmpty extends StoreState {
  final String message;

  const StoreEmpty(this.message);

  @override
  List<Object> get props => [message];
}

// Estado de conteo de tiendas (si tienes alguna funcionalidad relacionada)
class StoreCountState extends StoreState {
  final int quantity;

  const StoreCountState({this.quantity = 1}); // Inicializamos con 1

  StoreCountState copyWith({int? quantity}) {
    return StoreCountState(
      quantity: quantity ?? this.quantity,
    );
  }
}

// Estado de éxito cuando se recuperan las tiendas
class StoreSuccess extends StoreState {
  final Store store;

  const StoreSuccess(this.store);

  @override
  List<Object> get props => [store];
}

// Estado cuando se actualizan los datos de la tienda (como nombre, dirección, etc.)
class StoreDataUpdated extends StoreState {
  final String name;
  final String description;

  const StoreDataUpdated({
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [name, description];
}

// Estado de error al cargar tiendas
class StoreFailure extends StoreState {
  final String error;

  const StoreFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Estado cuando se actualizan los datos enviados de la tienda
class StoreSubmittedUpdated extends StoreState {
  final StoreElement storeElement;

  const StoreSubmittedUpdated(this.storeElement);

  @override
  List<Object> get props => [storeElement];
}

// Estado mientras se envía la tienda a la API
class StoreSubmitting extends StoreState {}

// Estado de éxito cuando se envía la tienda a la API
class StoreSubmittedSuccess extends StoreState {}

// Estado de error al enviar la tienda a la API
class StoreSubmittedFailure extends StoreState {
  final String error;

  const StoreSubmittedFailure({required this.error});

  @override
  List<Object> get props => [error];
}
