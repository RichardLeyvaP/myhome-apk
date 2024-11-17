import 'package:signals/signals.dart';
import 'package:myhome/domain/modelos/category_model.dart';

// Signals para manejar el estado
final Signal<List<Category>> categoriesSignalPCS = Signal<List<Category>>([]);
final Signal<List<Status>> statusSignalPCS = Signal<List<Status>>([]);
final Signal<int?> selectedStatusIdSignalPCS = Signal<int?>(null);
final Signal<int?> selectedCategoryIdSignalPCS = Signal<int?>(null);
final Signal<int?> quantityProductSignalPCS = Signal<int?>(null);
final Signal<String> categoriesErrorSignalPCS = Signal<String>("");

final Signal<bool> isLoadingSignalPCS = Signal<bool>(false);
final Signal<bool?> isErrorSignalPCS = Signal<bool?>(null);
