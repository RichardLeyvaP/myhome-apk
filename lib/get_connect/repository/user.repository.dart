// ignore_for_file: depend_on_referenced_packages

import 'package:myhome/views/env.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserRepository extends GetConnect {
  Future getUserLoggedIn(String email, String password) async {
    try {
      var url = '${Env.apiEndpoint}/login';

      final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };
      final response = await post(url, body);
      print(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final users = response.body;
        print('1dentro del code:200');
        print('final users:$users');
        if (users != null) {
          print('2dentro del code:200 y tiene usuarios');
          print(users);
          return users;
        } else {
          print(
              '3dentro del code:200 pero retorno null es porque algo dio nul , la sucursal puede ser');
          return null;
        }
      } else {
        print('4No entro al code:200 este es el codigo:${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('5Error estoy en el catch (e) y este es el error:$e');
    }
  }

  Future userLogout(String token) async {
    try {
      var url = '${Env.apiEndpoint}/logout';

      // Parámetros que deseas enviar en la solicitud POST
      /*   final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };*/

      final headers = {
        "Authorization": "Bearer $token", // Agrega el token a los encabezados
      };

      final response = await get(url, headers: headers);
      //print(response.body);
      if (response.statusCode == 200) {
        final users = response.body;
        if (users != null) {
          return users;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error:$e');
      return e;
    }
  }
}
