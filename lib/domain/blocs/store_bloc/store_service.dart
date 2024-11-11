// store_signal.dart
import 'package:myhome/domain/blocs/store_bloc/store_signal.dart';
import 'package:myhome/data/models/store/store_model.dart';
import 'package:myhome/data/repository/store_repository.dart';

class StoreService {
  final StoreRepository storeRepository;

  StoreService({required this.storeRepository});

  // Método para obtener tiendas
  Future<void> requestStore() async {
    isStoreLoading.value = true;
    try {
      final result = await storeRepository.getStore();
      isStoreLoading.value = false;

      if (result is String) {
        storeMessage.value = result;
        storeData.value = null;
      } else if (result is Store) {
        storeData.value = result;
        storeMessage.value = "Stores loaded successfully";
      }
    } catch (error) {
      isStoreLoading.value = false;
      storeMessage.value = "Error: ${error.toString()}";
    }
  }

  // Método para actualizar datos de la tienda
  void updateStoreData(StoreElement updatedStoreElement) {
    currentStoreElement.value = (currentStoreElement.value ?? const StoreElement()).copyWith(
      name: updatedStoreElement.name ?? currentStoreElement.value?.name,
      description: updatedStoreElement.description ?? currentStoreElement.value?.description,
      location: updatedStoreElement.location ?? currentStoreElement.value?.location,
    );
  }

  // Método para enviar tienda a la API
  Future<void> submitStore() async {
    isSubmitting.value = true;
    try {
      await storeRepository.addStore(currentStoreElement.value!);
      isSubmitting.value = false;
      submitSuccess.value = true;
      submitError.value = null;
    } catch (error) {
      isSubmitting.value = false;
      submitSuccess.value = false;
      submitError.value = error.toString();
    }
  }

  // Métodos para incrementar y disminuir la cantidad
  void increaseStoreQuantity() {
    storeQuantity.value = storeQuantity.value + 1;
  }

  void decreaseStoreQuantity() {
    if (storeQuantity.value > 1) {
      storeQuantity.value = storeQuantity.value - 1;
    }
  }
}
