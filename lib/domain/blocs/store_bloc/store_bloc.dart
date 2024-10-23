import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/store/store_model.dart';
import 'package:myhome/data/repository/store_repository.dart';
import 'package:myhome/domain/blocs/store_bloc/store_event.dart';
import 'package:myhome/domain/blocs/store_bloc/store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository storesRepository;

  // Mantiene el estado de la tienda actual
  StoreElement _storeElement = const StoreElement();
  int count = 0;

  StoreBloc({required this.storesRepository}) : super(StoreInitial()) {
    on<StoreRequested>(_onStoreRequested);
    on<StoreSubmitted>(_onStoreSubmitted);
    on<StoreUpdated>(_onStoreDataUpdated);
    on<IncreaseStoreQuantity>((event, emit) {
      // Aumentar la cantidad
      emit((state as StoreCountState).copyWith(quantity: (state as StoreCountState).quantity + 1));
    });

    on<DecreaseStoreQuantity>((event, emit) {
      // Disminuir la cantidad si es mayor que 1
      int currentQuantity = (state as StoreCountState).quantity;
      if (currentQuantity > 1) {
        emit((state as StoreCountState).copyWith(quantity: currentQuantity - 1));
      }
    });
  }

  // Método para obtener el estado actual de la cantidad
  int get currentQuantity => (state as StoreCountState).quantity;

  // Manejar solicitud de tiendas
  Future<void> _onStoreRequested(StoreRequested event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final result = await storesRepository.getStore(); // Obtener las tiendas

      if (result is String) {
        emit(StoreEmpty(result));
      } else if (result is Store) {
        emit(StoreSuccess(result));
      }
    } catch (error) {
      emit(StoreFailure(error.toString()));
    }
  }

  // Manejar actualización de los datos de la tienda
  void _onStoreDataUpdated(StoreUpdated event, Emitter<StoreState> emit) {
    _storeElement = _storeElement.copyWith(
      name: event.storeElement.name ?? _storeElement.name,
      description: event.storeElement.description ?? _storeElement.description,
      location: event.storeElement.location ?? _storeElement.location,
    );

    emit(StoreSubmittedUpdated(_storeElement));
  }

  // Manejar envío de la tienda a la API
  Future<void> _onStoreSubmitted(StoreSubmitted event, Emitter<StoreState> emit) async {
    emit(StoreSubmitting());
    try {
      await storesRepository.addStore(_storeElement); // Enviar la tienda completa a la API
      emit(StoreSubmittedSuccess());
    } catch (error) {
      emit(StoreSubmittedFailure(error: error.toString()));
    }
  }
}
