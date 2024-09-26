import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  String? baseUrl;
  String? token;

  ApiService({this.baseUrl, this.token});

  // Método general para iniciar sesión
  Future<Map<String, dynamic>> login({
    String? facebookToken,
    String? googleToken,
    String? username,
    String? password,
  }) async {
    if (facebookToken != null) {
      return loginWithTokenFacebook(facebookToken);
    } else if (googleToken != null) {
      return loginWithTokenGoogle(googleToken);
    } else if (username != null && password != null) {
      return loginWithCredentials(username, password);
    } else {
      throw Exception('Datos de autenticación insuficientes.');
    }
  }

  // Método GET
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: _headers(),
    );
    return _processResponse(response);
  }

  // Método POST
  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body}) async {
    print('aqui estoy entrando-al metodo-post44-$endpoint');
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _headers(),
        body: jsonEncode(body),
      );
      print('aqui estoy entrando-al metodo-post-task-response.statusCode${response.statusCode}');
      print('aqui estoy entrando-al metodo-post-${response.body}');
      return _processResponse(response);
    } on SocketException catch (e) {
      print('Error de red (SocketException): $e');
      throw Exception('Error de red: No se pudo conectar al servidor.');
    } on HttpException catch (e) {
      print('Error HTTP (HttpException): $e');
      throw Exception('Error HTTP: La solicitud al servidor falló.');
    } on FormatException catch (e) {
      print('Error de formato (FormatException): $e');
      throw Exception('Error de formato: La respuesta no tiene un formato esperado.');
    } catch (e, stacktrace) {
      print('Error general (Exception): $e');
      print('Stacktrace: $stacktrace');
      throw Exception('Error desconocido: $e');
    }
  }

  // Método PUT
  Future<dynamic> put(String endpoint, {required Map<String, dynamic> body}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  // Método DELETE
  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
    );
    return _processResponse(response);
  }

  // Método para obtener los encabezados
  Map<String, String> _headers() {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

// Método para procesar la respuesta
  dynamic _processResponse(http.Response response) {
    print('dando click en la imagen-5:${response.statusCode})');
    //  print('dando click en la imagen-5:${jsonDecode(response.body)})');
    print('entrando a * - : getCategoriesPriority-3:${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        // Código 200 OK: La solicitud se realizó correctamente y se obtuvo una respuesta
        return jsonDecode(response.body);
      case 201: //es que insertó
        // Código 200 OK: La solicitud se realizó correctamente y se obtuvo una respuesta
        return jsonDecode(response.body);
      case 204:
        // Código 204 OK: La solicitud se realizó correctamente y se obtuvo una respuesta vacia
        return 'No hay resultados';
      case 401:
        return jsonDecode(response.body);
      case 404:
        return 'No encontró la dirección statusCode:404';

      default:
        // Otros códigos de estado: Manejo de errores
        throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  // Método para iniciar sesión con usuario y contraseña
  Future<Map<String, dynamic>> loginWithCredentials(String username, String password) async {
    print('aqui estoy entrando... 1');
    final endpoint = 'http://10.0.2.2:8000/api/login-apk';
    final body = {
      'email': username,
      'password': password,
    };
    print('aqui estoy entrando... 2');
    try {
      // Realiza la solicitud POST

      // Procesa la respuesta
      return await post(endpoint, body: body);
    } catch (e) {
      // Manejo de errores específico para el login
      print('Error en el login: $e');
      throw Exception('Error en el login');
    }
  }

// Método para iniciar sesión con un token de terceros (Google)
  Future<Map<String, dynamic>> loginWithTokenGoogle(String thirdPartyToken) async {
    final endpoint = '/google-callback-apk'; // Asegúrate de que este endpoint sea correcto
    final body = {
      'token': thirdPartyToken,
    };

    try {
      // Realiza la solicitud POST
      final response = await post(endpoint, body: body);

      // Procesa la respuesta
      final data = _processResponse(response);

      // Asignar el token al recibir la respuesta, si es necesario
      if (data.containsKey('token')) {
        token = data['token'];
      } else {
        throw Exception('El token no está presente en la respuesta');
      }

      return data;
    } catch (e) {
      // Manejo de errores específico para el login con Google
      print('Error en el login con Google: $e');
      throw Exception('Error en el login con Google');
    }
  }

  // Método para iniciar sesión con un token de terceros (Facebook)
  Future<Map<String, dynamic>> loginWithTokenFacebook(String thirdPartyToken) async {
    final endpoint = '/facebook-callback-apk'; // Asegúrate de que este endpoint sea correcto
    final body = {
      'token': thirdPartyToken,
    };

    try {
      // Realiza la solicitud POST
      final response = await post(endpoint, body: body);

      // Procesa la respuesta
      final data = _processResponse(response);

      // Asignar el token al recibir la respuesta, si es necesario
      if (data.containsKey('token')) {
        token = data['token'];
      } else {
        throw Exception('El token no está presente en la respuesta');
      }

      return data;
    } catch (e) {
      // Manejo de errores específico para el login con Facebook
      print('Error en el login con Facebook: $e');
      throw Exception('Error en el login con Facebook');
    }
  }

  logout() {
    //implementar el logout
  }
}
