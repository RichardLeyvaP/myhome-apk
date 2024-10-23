import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';

class TasksRepository {
  final ApiService authService;

  TasksRepository({required this.authService});

  Future<dynamic> getCategoriesStatusPriority() async {
    print('dando click en la getProduct');
    final endpoint = 'http://10.0.2.2:8000/api/category-status-priority-apk';
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
      throw Exception('getCategoriesStatusPriority(): $e');
    }
  }

  Future<dynamic> getTasks(date) async {
    print('dando click en la imagen-2');
    final endpoint = 'http://10.0.2.2:8000/api/task-date-apk?start_date=$date';

    try {
      // Llama al servicio y obtiene la respuesta procesada
      final response = await authService.get(endpoint);

      // Verificamos si response es un JSON válido
      if (response is Map<String, dynamic>) {
        // Deserializamos la respuesta a nuestro modelo TaskResponse
        print('dando click en la imagen-3:$response');
        final taskResponse = Task.fromJson(response);
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
      throw Exception('getTasks(date): $e');
    }
  }

  void showTasks(String date) async {
    try {
      final taskResponse = await getTasks(date);

      // Puedes usar taskResponse.tasks para mostrar los datos
      for (var task in taskResponse.tasks) {
        print('Tarea: ${task.title}');
      }
    } catch (e) {
      print('Error en showTasks: $e');
    }
  }

//metodo para agregar una tarea
  Future<dynamic> addTasks(TaskElement task) async {
    const endpoint = 'http://10.0.2.2:8000/api/task';
    //  const endpoint = 'http://10.0.2.2:8000/api/task-test';
    final body = {
      //'task': task,
      'title': task.title,
      'description': task.description,
      'start_date': task.startDate,
      'end_date': task.endDate,
      'priority_id': task.priorityId, //llegando null
      'parent_id': task.parentId,
      'status_id': task.statusId,
      'category_id': task.categoryId, //todo valor fijo
      // 'category_id': task.categoryId,
      'recurrence': task.recurrence,
      'estimated_time': task.estimatedTime,
      'comments': task.comments,
      'attachments': task.attachments,
      'geo_location': 'task.geoLocation' //todo valor fijo
    };
    print('si estoy devolviendo esto:1-BODY-${body}');
    // Llama al servicio que maneja la API de autenticación para login
    final response = await authService.post(endpoint, body: body);

    print('si estoy devolviendo esto:1-${response}');
  }
}
