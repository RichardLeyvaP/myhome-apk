import 'dart:async';
import 'package:myhome/domain/Controllers/login.controller.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoadingPage(),
    );
  }
}

class MyLoadingPage extends StatefulWidget {
  @override
  _MyLoadingPageState createState() => _MyLoadingPageState();
}

class _MyLoadingPageState extends State<MyLoadingPage> {
  final LoginController cLogin = Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (cLogin.usserMssQr == 1) {
        Timer(Duration(seconds: 3), () async {
          //no ha leido correctamente el qr
          print('no ha leido correctamente el qr');
          cLogin.setUsserMssQr(-99);
        });
      } else if (cLogin.usserMssQr == 0) {
        Timer(Duration(seconds: 3), () async {
          //no coincide correctamente el qr
          print('no coincide correctamente el qr');
        });
        cLogin.setUsserMssQr(-99);
      }
      // Iniciar un temporizador de 2 segundos
      Timer(const Duration(seconds: 2), () async {
//VERIFICAR QUE ESTE td este bien

        if (cLogin.chargeUser == "Opcion1") {
          // Navegar a la nueva página

          Get.offAllNamed('/PagePdf');
        } else if (cLogin.chargeUser == "Opcion2") {
          Get.offAllNamed('/PagePdf');
        } else {
          Get.offAllNamed('/LoginFormPage');
        }
        // } else {
        //   Get.offAllNamed('/LoginFormPage');
        // }
      });
    });
    //

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
                //  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDAE2A)),
                ),
            const SizedBox(height: 16),
            Text(
              TranslationManager.translate('loadTitle'),
              style: const TextStyle(
                fontSize: 18,
                // color: Color(0xFFFDAE2A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
