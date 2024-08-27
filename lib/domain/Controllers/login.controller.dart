// ignore_for_file: depend_on_referenced_packages

import 'package:myhome/domain/repository/user.repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class LoginController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      update();
    });
  }

  bool vLocale = true;
  UserRepository usuarioLg = UserRepository();
  bool isLoading = true;
  String greeting = 'Buenos días ';
  bool obscureText = true;
  String pathPdf = '';

  //variables del modulo Qr
  int usserMssQr = -99;
  bool qrReader = false;
  String page = 'nothing';
  setUsserMssQr(value) {
    usserMssQr = value;
    update();
  }

  setQrReader(value) {
    qrReader = value;
    update();
  }

  bool getQrReader() {
    return qrReader;
  }
  //fin variables del modulo Qr

  //variables del usuario
  String chargeUser = '';
  String userNameQR = '';
  String emailQR = '';
  String horaQR = '';
  //variables del usuario

//metodos del modulo de qr

  Future<bool> qrReading(String? qr) async {
    //todo falta poner un cargando
    print('esto es lo que entre aqui a el controlador de lectura del QR${qr.toString()}');
    Map<String, dynamic> jsonMap = json.decode(qr.toString());
    print('esto es lo que ......................Objeto JSON: $jsonMap');

    userNameQR = jsonMap['userName'];
    print('esto es lo que-1');
    emailQR = jsonMap['email'];
    print('esto es lo que-2');
    horaQR = jsonMap['hora'];
    print('esto es lo que-3');

    //

    //

    // if (userNameQR == 'Usuario' && emailQR == 'email') {
    if ('Usuario' == 'Usuario' && 'email' == 'email') {
      qrReader = true;
      chargeUser = 'Opcion1';
      usserMssQr = 1; //SE CREO CORRECTAMENTE EL QR
      update();
      //  Get.offAllNamed('/Professional');
      return true;
    } else {
      usserMssQr = 0; //NO SE CREO CORRECTAMENTE EL QR
      update();
      return false;
    }
  }

//fin metodos del modulo de qr
  void togglePasswordVisibility() {
    obscureText = !obscureText;
    update();
  }

  void setVlocale() {
    vLocale ? false : true;
    update();
  }

  var isDarkMode = false.obs;

  void toggleTheme() {
    print('esto devuelve Get.isDarkMode:-desde el controlador1  :${Get.isDarkMode}');
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    update();

    print('esto devuelve Get.isDarkMode:-desde el controlador2  :${Get.isDarkMode}');
  }

  Future<void> getIsLoading(bool value) async {
    isLoading = value;
    update();
  }

  void getGreeting() {
    // Obtener la hora actual
    DateTime now = DateTime.now();

    // Obtener la hora del día
    int hour = now.hour;

    // Determinar el saludo según la hora

    if (hour < 12) {
      greeting = 'Buenos días ';
    } else if (hour < 18) {
      greeting = 'Buenas tardes ';
    } else {
      greeting = 'Buenas noches ';
    }
    update();
  }

//
//
  // openFilePdf() {
  //   OpenFile.open(pathPdf);
  // }

//
//

  alertDialog(String msj, String btn1Text, String btn1Route, String btn2Tex, String btn2Route) {
    Get.dialog(
      AlertDialog(
        title: Text(msj),
        actions: [
          TextButton(
            onPressed: () {
              if (btn1Route != '') {
                Get.toNamed(
                  btn1Route,
                );
              } else {
                Get.back(result: true);
              }
            },
            // onPressed: () =>
            //     Get.back(result: false),
            child: Text(btn1Text),
          ),
          TextButton(
            onPressed: () {
              if (btn2Route != '') {
                Get.toNamed(
                  btn2Route,
                );
              } else {
                Get.back(result: true);
              }
            },
            child: Text('Salir'),
          ),
        ],
      ),
    );
  }
}
