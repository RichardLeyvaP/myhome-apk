import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  String? token;

  ApiService({required this.baseUrl, this.token});

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
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
    );
    return _processResponse(response);
  }

  // Método POST
  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _processResponse(response);
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
    switch (response.statusCode) {
      case 200:
        // Código 200 OK: La solicitud se realizó correctamente y se obtuvo una respuesta
        return jsonDecode(response.body);

      case 201:
        // Código 201 Created: La solicitud se realizó correctamente y se creó un nuevo recurso
        print('Recurso creado exitosamente.');
        return jsonDecode(response.body);

      case 204:
        // Código 204 No Content: La solicitud se realizó correctamente pero no hay contenido para devolver
        print('La solicitud se realizó correctamente, pero no hay contenido.');
        return null;

      default:
        // Otros códigos de estado: Manejo de errores
        throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  // Método para iniciar sesión con usuario y contraseña
  Future<Map<String, dynamic>> loginWithCredentials(String username, String password) async {
    final endpoint = '/login-apk'; // Asegúrate de que este endpoint sea correcto
    final body = {
      'email': username,
      'password': password,
    };

    try {
      // Realiza la solicitud POST
      final response = await post(endpoint, body: body);

      // Procesa la respuesta
      final data = _processResponse(response);

      // Si necesitas asignar el token aquí, asegúrate de hacerlo de manera segura
      if (data.containsKey('token')) {
        token = data['token'];
      } else {
        throw Exception('El token no está presente en la respuesta');
      }

      return data;
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
}
