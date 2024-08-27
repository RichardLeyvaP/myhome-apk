// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/domain/Controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:myhome/ui/myApp.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:myhome/data/services/authFacebook_service.dart';
import 'package:myhome/data/services/authGoogle_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginFormPage extends StatefulWidget {
  LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  @override
  void initState() {
    print('llegando a la pagina de loginFb');
    super.initState();
    //  _checkingIfLogget();
  }

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _usserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<RoutesCubit>();
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 30.0,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            const Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://img.freepik.com/foto-gratis/villa-lujo-piscina-espectacular-diseno-contemporaneo-arte-digital-bienes-raices-hogar-casa-propiedad-ge_1258-150749.jpg'),
                      // width: 350,
                      // height: 600,
                    ),
                  ],
                )),
            Expanded(
                flex: 10,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, //todo
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                    child: GetBuilder<LoginController>(builder: (_) {
                      return Column(
                        children: [
                          TextField(
                            controller: _usserController,
                            decoration: InputDecoration(
                              hintText: 'Usuario',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0), // Color del borde
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color.fromARGB(90, 0, 0, 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            obscureText: _.obscureText,
                            controller: _passController,
                            //maxLines: 3,
                            decoration: InputDecoration(
                              //labelText: 'Pass',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0), // Color del borde
                              ),

                              hintText: 'Contraseña', // Este es el placeholder
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color.fromARGB(90, 0, 0, 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _.obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _.togglePasswordVisibility,
                              ),
                              fillColor: const Color.fromARGB(14, 96, 125, 139),
                              filled: true,

                              labelStyle: const TextStyle(
                                color: Color.fromARGB(176, 0, 0, 0), // Cambia el color del texto aquí
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                  onTap: () {
                                    // Get.offAllNamed('/AuthCheck');
                                    //se está trabajndo en ese modulo
                                    print('se está trabajndo en ese modulo');
                                  },
                                  child: const Text('Olvidé mi contraseña'))),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 60.0), // Ajusta el padding
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                      // Añadir más propiedades de estilo aquí
                                    ),
                                    onPressed: () async {
                                      if (_usserController.text.isEmpty || _passController.text.isEmpty) {
                                        _passController.text = '';
                                        _usserController.text = '';
                                        //mostrar snackbar error aqui
                                        //no tiene datos
                                        print('no tiene datos loguearse');
                                      } else {
                                        await _.getIsLoading(true);

                                        Future.delayed(const Duration(seconds: 1), () async {
                                          _.getIsLoading(false);
                                          // Espera a que la navegación a la nueva página se complete
                                          userCubit.goHome();

                                          //context.go('/NewPage')//borra y remplaza la cola de rutas
                                          //context.push('/NewPage')//mantiene la cola de rutas

                                          // Una vez que la navegación está completa, cierra el diálogo de carga
                                          // Navigator.of(context).pop();
                                        });

                                        /*  await _.loginGetIn(
                                            _usserController.text,
                                            _passController.text);
                                        if (_.incorrectFields == true) {
                                          Get.snackbar(
                                            '',
                                            'Usuario o Contraseña Incorrectos.',
                                            colorText: Colors.black,
                                            titleText: const Text('Error'),
                                            duration:
                                                const Duration(seconds: 2),
                                            showProgressIndicator: true,
                                            progressIndicatorBackgroundColor:
                                                const Color.fromARGB(
                                                    255, 81, 93, 117),
                                            progressIndicatorValueColor:
                                                const AlwaysStoppedAnimation(
                                                    Color.fromARGB(
                                                        255, 241, 130, 84)),
                                            overlayBlur: 3,
                                          );
                                        }*/
                                      }
                                    },
                                    child: _.isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w800),
                                          )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          SizedBox(
                            width: double.infinity, // Ocupa todo el ancho disponible
                            height: 50,
                            child: SignInButton(
                              Buttons.google,
                              text: "Entrar con Google",
                              onPressed: () {
                                loginWithGoogle(context);
                                // Tu lógica de inicio de sesión
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity, // Ocupa todo el ancho disponible
                            height: 50,
                            child: SignInButton(
                              Buttons.facebook,
                              text: "Entrar con facebook",
                              onPressed: () {
                                loginFb(setState, context);
                                // Tu lógica de inicio de sesión
                              },
                            ),
                          )
                          // ElevatedButton.icon(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.white,
                          //     foregroundColor: Colors.black, // Color del texto e ícono de Google
                          //     side: const BorderSide(color: Colors.black), // Borde del botón
                          //     minimumSize: const Size(double.infinity, 50),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //   ),
                          //   icon: const FaIcon(
                          //     FontAwesomeIcons.google,
                          //     color: Colors.red, // Color del ícono de Google
                          //   ),
                          //   label: const Text(
                          //     'Entrar con Google',
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                          //   onPressed: () {
                          //     // Acción al presionar el botón de Google
                          //     loginWithGoogle();
                          //   },
                          // ),

                          /* InkWell(
                            onTap: () {
                              userCubit.goAuthCheck();
                            },
                            child: Image(
                              image:
                                  AssetImage('assets/images/fingerprint.jpg'),
                              width: 80,
                              height: 60,
                            ),
                          ),*/
                        ],
                      );
                    }),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
