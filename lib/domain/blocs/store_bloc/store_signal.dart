import 'package:signals/signals.dart';
import 'package:myhome/data/models/store/store_model.dart';

// Definición de señales para el estado
final Signal<StoreElement?> currentStoreElementST = Signal<StoreElement?>(null);
final Signal<int> storeQuantityST = Signal<int>(1);
final Signal<bool> isStoreLoadingST = Signal<bool>(false);
final Signal<String?> storeErrorST = Signal<String?>(null);
final Signal<String?> storeEmpyST = Signal<String?>(null);
final Signal<Store?> storeDataST = Signal<Store?>(null);
final Signal<bool> isSubmittingST = Signal<bool>(false);
final Signal<bool> submitSuccessST = Signal<bool>(false);
final Signal<String?> submitErrorST = Signal<String?>(null);
