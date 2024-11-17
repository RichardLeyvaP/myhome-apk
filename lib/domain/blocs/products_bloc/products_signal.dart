import 'package:signals/signals.dart';
import 'package:myhome/data/models/products/product_model.dart';

// Signals para manejar el estado
final Signal<Product?> productSignal = Signal<Product?>(null);
final Signal<ProductElement> productElementSignal = Signal<ProductElement>(const ProductElement());
final Signal<int> quantitySignal = Signal<int>(1); // Inicia en 1

final Signal<bool> isLoadingSignalPR = Signal<bool>(false);
final Signal<String?> productErrorSignal = Signal<String?>(null);
final Signal<String?> productEmpySignal = Signal<String?>(null);
final Signal<String> submitErrorSignal = Signal<String>("");

final Signal<bool> isProductSubmittingSignal = Signal<bool>(false);
final Signal<bool> productSubmittedSuccessSignal = Signal<bool>(false);
