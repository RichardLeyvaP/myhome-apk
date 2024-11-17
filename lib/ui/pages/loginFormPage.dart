// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myhome/domain/blocs/login_bloc/login_bloc.dart';
import 'package:myhome/domain/blocs/login_bloc/login_event.dart';
import 'package:myhome/domain/blocs/login_bloc/login_service.dart';
import 'package:myhome/domain/blocs/login_bloc/login_signal.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/data/services/authFacebook_service.dart';
import 'package:myhome/data/services/authGoogle_service.dart';
import 'package:myhome/domain/blocs/tasks/tasks_service.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:signals/signals_flutter.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  @override
  void initState() {
    // Ejecutar una función después de que se haya renderizado
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loginFuntion();
    // });
    super.initState();
  }

  //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  loginFuntion() {
    if (isLoadingLG.watch(context) == true) {
      // Muestra un mensaje de carga
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando sesión...')),
      );
    } else if (isLoggedInLG.watch(context) == false) {
      //esta vacio
      // Muestra un mensaje de carga
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginMessageLG.value)), //13295---36,000.00
      );
    } else if (isLoggedInLG.watch(context) == true) {
      //está logueado
      // Navega a la página de inicio o realiza alguna acción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginMessageLG.value)),
      );
      GoRouter.of(context).go(
        '/HomePrincipal',
        extra: {
          'name': currentUserLG.value!.userName,
          'email': currentUserLG.value!.email,
          'avatarUrl': '',
        },
      );
      // String date = '2024-09-09'; // La fecha puede ser dinámica
      DateTime selectedDay = DateTime.now();
      //String date = '2024-09-09'; // La fecha puede ser dinámica
      String date = DateFormat('yyyy-MM-dd').format(selectedDay);
      fetchTasks(date);
      //llamar la stareas del día
      // context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento

      //Navigator.of(context).pushReplacementNamed('/home');
    } else if (isLoginErrorLG.watch(context) == true) {
      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${loginMessageLG.value}')),
      );
    }
  }

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Ejecutar una función después de que se haya renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginFuntion();
    });
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 10.0,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Huoon',
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Colors.white,
                            // Cambia alguna propiedad aqui
                          ),
                    ),
                  ],
                )),
            Expanded(
                flex: 12,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, //todo
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                    child: Column(
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
                          controller: _passController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0), // Color del borde
                            ),
                            hintText: 'Contraseña',
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
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            fillColor: const Color.fromARGB(14, 96, 125, 139),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () {
                                  print('se está trabajndo en ese modulo');
                                },
                                child: Text(TranslationManager.translate('rememberPassword')))),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                                    ),
                                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                                  ),
                                  onPressed: () async {
                                    // analytics.logEvent(
                                    //   name: 'screen_view_Select_category',
                                    //   parameters: <String, String>{
                                    //     'screen_name': 'ScreenInsertTask',
                                    //   },
                                    // ).then((_) {
                                    //   print("firebase-Evento enviado correctamente.");
                                    // }).catchError((error) {
                                    //   print("firebase-Evento Error al enviar evento: $error");
                                    // });
                                    if (_usserController.text.isEmpty || _passController.text.isEmpty) {
                                      _passController.clear();
                                      _usserController.clear();
                                      print('no tiene datos loguearse');
                                    } else {
                                      login(_usserController.text, _passController.text);

                                      // BlocProvider.of<LoginBloc>(context).add(
                                      //   LoginRequested(
                                      //     _usserController.text,
                                      //     _passController.text,
                                      //   ),
                                      // );
                                    }
                                  },
                                  child: Text(
                                    TranslationManager.translate('loginButton'),
                                    style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w800),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: SignInButton(
                            Buttons.google,
                            text: TranslationManager.translate('googleButton'),
                            onPressed: () {
                              loginWithGoogle(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: SignInButton(
                            Buttons.facebook,
                            text: TranslationManager.translate('facebookButton'),
                            onPressed: () {
                              loginFb(setState, context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
