import 'package:myhome/data/models/login/login_model.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';

class TasksRepository {
  final ApiService authService;

  TasksRepository({required this.authService});

  Future<dynamic> getTasks(date) async {
    print('dando click en la imagen-2');
    final endpoint = 'http://10.0.2.2:8000/api/task-date-apk-test?start_date=$date';

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
      throw Exception('Error al obtener las tareas: $e');
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
    const endpoint = 'http://10.0.2.2:8000/api/task-test';
    final body = {
      //'task': task,
      'title': task.title,
      'description': task.description,
      'start_date': task.startDate,
      'end_date': task.endDate,
      'priority_id': task.priorityId,
      'parent_id': task.parentId,
      'status_id': task.statusId,
      'category_id': task.categoryId,
      'recurrence': task.recurrence,
      'estimated_time': task.estimatedTime,
      'comments': task.comments,
      'attachments': task.attachments,
      'geo_location': 'task.geoLocation'
    };
    // Llama al servicio que maneja la API de autenticación para login
    final response = await authService.post(endpoint, body: body);
    // final response = await authService.loginWithCredentials(email, password);
    // Extrae el token del Map<String, dynamic>
    // Crea una instancia de `Login` con los datos de la respuesta de la API

    print('si estoy devolviendo esto:1-${response}');
    /*  if (response.containsKey('token')) {
      final user = Login(
        id: response['id'] as int,
        userName: response['userName'] as String,
        email: response['email'] as String,
        token: response['token'] as String,
      );
      return user;
    } else if (response.containsKey('msg')) {
      return response['msg'] as String;
    } else {
      print('aqui estoy entrando-error');
      throw Exception('Token no presente en la respuesta');
    }*/
  }
}
