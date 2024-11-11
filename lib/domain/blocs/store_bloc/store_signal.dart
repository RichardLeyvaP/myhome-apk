import 'package:signals/signals.dart';
import 'package:myhome/data/models/store/store_model.dart';

// Definición de señales para el estado
final Signal<StoreElement?> currentStoreElement = Signal<StoreElement?>(null);
final Signal<int> storeQuantity = Signal<int>(1);
final Signal<bool> isStoreLoading = Signal<bool>(false);
final Signal<String> storeMessage = Signal<String>("");
final Signal<Store?> storeData = Signal<Store?>(null);
final Signal<bool> isSubmitting = Signal<bool>(false);
final Signal<bool> submitSuccess = Signal<bool>(false);
final Signal<String?> submitError = Signal<String?>(null);
