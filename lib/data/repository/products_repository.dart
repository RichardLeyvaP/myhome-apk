import 'package:myhome/data/models/productCategoriesStatus/product_categories_status.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';

class ProductsRepository {
  final ApiService authService;

  ProductsRepository({required this.authService});

  Future<dynamic> getProduct() async {
    print('dando click en la getProduct');
    final endpoint = 'http://10.0.2.2:8000/api/products';

    try {
      // Llama al servicio y obtiene la respuesta procesada
      final response = await authService.get(endpoint);

      // Verificamos si response es un JSON válido
      if (response is Map<String, dynamic>) {
        // Deserializamos la respuesta a nuestro modelo TaskResponse
        final taskResponse = Product.fromJson(response);
        // Retornamos el modelo deserializado
        print('dando click en la imagen-3:$taskResponse');
        return taskResponse;
      } else if (response is String) {
        print('dando click en la imagen-4:$response');
        return response;
      } else {
        print('dando click en la imagen-5:$response');
        throw Exception('Respuesta inesperada del servidor.Revise su conexión');
      }
    } catch (e) {
      print('dando click en la imagen-4:$e');
      // Manejo de errores
      throw Exception('getProduct(): $e');
    }
  }

//metodo para agregar una tarea
  Future<dynamic> addProduct(ProductElement product) async {
    const endpoint = 'http://10.0.2.2:8000/api/products';
    print('*****************************************************************');
    print(product.name);
    print(product.categoryId);
    print(product.statusId);
    print(product.quantity);
    print(product.unitPrice);
    print(product.purchaseDate);
    print(product.purchasePlace);
    print(product.expirationDate);
    print(product.brand);
    print(product.additionalNotes);
    final body = {
      'name': product.name,
      'category_id': product.categoryId,
      'status_id': 4, //todo valor fijo
      // 'status_id': product.statusId,
      'quantity': 1,
      //'quantity': product.quantity,
      'unit_price': product.unitPrice,
      'purchase_date': product.purchaseDate,
      'purchase_place': product.purchasePlace,
      'expiration_date': product.expirationDate?.toLocal().toIso8601String().split('T')[0], // Solo la fecha
      'brand': product.brand,
      'additional_notes': product.additionalNotes,
      // 'image': product.image,
      //
      // 'name': 'tarea nueva apk',
      // 'category_id': 1,
      // 'status_id': 1,
      // 'quantity': 2,
      // 'unit_price': 20,
      // 'purchase_date': '2024-12-23 23:20:00',
      // 'purchase_place': 'lugar',
      // 'expiration_date': '2024-12-28',
      // 'brand': null,
      // 'additional_notes': 'nota',
      //'image': "products/1.jpg",
    };
    // Llama al servicio que maneja la API de autenticación para login
    final response = await authService.post(endpoint, body: body);

    print('si estoy devolviendo esto:1-${response}');
  }

  Future<dynamic> getCategoriesPriority() async {
    print('dando click en la getProduct');
    final endpoint = 'http://10.0.2.2:8000/api/productcategory-productstatus-apk';
    print('entrando a * - : getCategoriesPriority-2');
    try {
      // Llama al servicio y obtiene la respuesta procesada
      final response = await authService.get(endpoint);
      print('entrando a * - : getCategoriesPriority-2.1;$response');
      // Verificamos si response es un JSON válido
      if (response is Map<String, dynamic>) {
        print('entrando a * - : getCategoriesPriority-2.2');
        // Deserializamos la respuesta a nuestro modelo TaskResponse
        print('entrando a * - : getCategoriesPriority-2.3:${response['productcategories']}');

        // Mapea la lista de categorías desde el JSON
        /*   final List<ProductCP> categories = (response['productcategories'] as List)
            .map((category) => ProductCP.fromJson(category as Map<String, dynamic>))
            .toList();*/

// Verifica el mapeo
        // print('entrando a * - :-Categorías mapeadas: $categories');
        final taskResponse = response;

        // Retornamos el modelo deserializado
        print('entrando a * - : getCategoriesPriority-2.4:$taskResponse');
        return taskResponse;
      } else if (response is String) {
        print('dando click en la imagen-4:$response');
        return response;
      } else {
        print('dando click en la imagen-5:$response');
        throw Exception('Respuesta inesperada del servidor.Revise su conexión');
      }
    } catch (e) {
      print('dando click en la imagen-4:$e');
      // Manejo de errores
      throw Exception('getCategoriesPriority(): $e');
    }
  }
}
