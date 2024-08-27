import 'dart:convert';

class PokeApi {
  get http => null;

  Future<void> getPokemon() async {
    final String api = 'https://pokeapi.co/api/v2/';
    final String Enpoint = 'pokemon/ditto';
    try {
      print('resp- entrando a loginWithGoogle');
      final url = Uri.parse('$api$Enpoint'); // URL de tu API
      try {
        final response = await http.get(url);
        // Imprime la respuesta completa
        print('resp- Response body: ${response.body}');
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          // Maneja la respuesta de la API, como los datos del usuario o token
          print('resp- Login exitoso: $responseData');
        } else {
          print('resp- Error al iniciar sesión: ${response.statusCode}');
        }
      } catch (error) {
        print('resp- Error en la solicitud: $error');
      }
    } catch (e) {
      print(e);
    }
  }
}
