import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/data/repository/products_repository.dart';
import 'package:myhome/domain/blocs/products_bloc/products_event.dart';
import 'package:myhome/domain/blocs/products_bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductState> {
  final ProductsRepository productsRepository;

  // Mantiene el estado de la tarea actual
  ProductElement _productElement = const ProductElement(
    categoryId: 0,
    name: '',
    statusId: 0,
    quantity: 0,
    unitPrice: '',
  );

  ProductsBloc({required this.productsRepository}) : super(ProductInitial()) {
    on<ProductsRequested>(_onTaskRequested);
    on<ProductSubmitted>(_onTaskSubmitted);
    on<ProductUpdated>(_onProductDataUpdated);
  }

  // Manejar solicitud de tareas
  Future<void> _onTaskRequested(ProductsRequested event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final result = await productsRepository.getProduct(); // Usar la fecha del evento

      if (result is String) {
        emit(ProductEmpty(result));
      } else if (result is Product) {
        emit(ProductSuccess(result));
      }
    } catch (error) {
      emit(ProductFailure(error.toString()));
    }
  }

//  String? purchaseDate,
//     DateTime? expirationDate,
//     String? purchasePlace,
//     String? brand,
//     String? additionalNotes,
//     String? image,
  // Manejar actualización de título y descripción
  void _onProductDataUpdated(ProductUpdated event, Emitter<ProductState> emit) {
    _productElement = _productElement.copyWith(
      name: event.productElement.name ?? _productElement.name,
      additionalNotes: event.productElement.additionalNotes ?? _productElement.additionalNotes,
      categoryId: event.productElement.categoryId ?? _productElement.categoryId,
      statusId: event.productElement.statusId ?? _productElement.statusId,
      unitPrice: event.productElement.unitPrice ?? _productElement.unitPrice,
      purchaseDate: event.productElement.purchaseDate ?? _productElement.purchaseDate,
      expirationDate: event.productElement.expirationDate ?? _productElement.expirationDate,
      purchasePlace: event.productElement.purchasePlace ?? _productElement.purchasePlace,
      brand: event.productElement.brand ?? _productElement.brand,
    );

    emit(ProductSubmittedUpdated(_productElement));
  }

  // Manejar envío de la tarea a la API
  Future<void> _onTaskSubmitted(ProductSubmitted event, Emitter<ProductState> emit) async {
    emit(ProductSubmitting());
    try {
      await productsRepository.addProduct(_productElement); // Enviar la tarea completa a la API
      emit(ProductSubmittedSuccess());
    } catch (error) {
      emit(ProductSubmittedFailure(error: error.toString()));
    }
  }
}
