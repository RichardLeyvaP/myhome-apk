// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/domain/blocs/login_bloc/login_bloc.dart';
import 'package:myhome/domain/blocs/login_bloc/login_event.dart';
import 'package:myhome/domain/blocs/login_bloc/login_state.dart'; // Asegúrate de que esté correctamente importado
import 'package:myhome/ui/myApp.dart';
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
  }

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<RoutesCubit>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('observando cambio del estado:$state');
        if (state is LoginLoading) {
          // Muestra un mensaje de carga
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Iniciando sesión...')),
          );
        } else if (state is LoginEmpty) {
          // Muestra un mensaje de carga
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${state.message}')),
          );
        } else if (state is LoginSuccess) {
          // Navega a la página de inicio o realiza alguna acción
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${state.user.userName}')),
          );
          GoRouter.of(context).go(
            '/HomePrincipal',
            extra: {
              'name': state.user.userName,
              'email': state.user.email,
              'avatarUrl': '',
            },
          );
          //Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is LoginFailure) {
          // Muestra un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: FadeIn(
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
                                  child: const Text('Olvidé mi contraseña'))),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                    ),
                                    onPressed: () async {
                                      if (_usserController.text.isEmpty || _passController.text.isEmpty) {
                                        _passController.clear();
                                        _usserController.clear();
                                        print('no tiene datos loguearse');
                                      } else {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginRequested(
                                            _usserController.text,
                                            _passController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w800),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: SignInButton(
                              Buttons.google,
                              text: "Entrar con Google",
                              onPressed: () {
                                loginWithGoogle(context);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: SignInButton(
                              Buttons.facebook,
                              text: "Entrar con facebook",
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
      ),
    );
  }
}
