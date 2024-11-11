import 'package:signals/signals.dart';
import 'package:myhome/domain/modelos/category_model.dart';

// Signals para manejar el estado
final Signal<List<Category>> categoriesSignal = Signal<List<Category>>([]);
final Signal<List<Status>> statusSignal = Signal<List<Status>>([]);
final Signal<int?> selectedStatusIdSignal = Signal<int?>(null);
final Signal<int?> selectedCategoryIdSignal = Signal<int?>(null);
final Signal<int?> quantityProductSignal = Signal<int?>(null);
final Signal<String> categoriesErrorSignal = Signal<String>("");

final Signal<bool> isLoadingSignal = Signal<bool>(false);
final Signal<bool> isErrorSignal = Signal<bool>(false);
