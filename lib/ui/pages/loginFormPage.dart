// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/data/services/globalCallApi/apiService.dart';
import 'package:myhome/domain/blocs/login_bloc/login_bloc.dart';
import 'package:myhome/domain/blocs/login_bloc/login_event.dart';
import 'package:myhome/domain/blocs/login_bloc/login_state.dart'; // Asegúrate de que esté correctamente importado
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/ui/myApp.dart';
import 'package:myhome/data/services/authFacebook_service.dart';
import 'package:myhome/data/services/authGoogle_service.dart';
import 'package:myhome/ui/util/util_class.dart';
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
            SnackBar(content: Text('Bienvenido ${state.user.userName}')),
          );
          GoRouter.of(context).go(
            '/HomePrincipal',
            extra: {
              'name': state.user.userName,
              'email': state.user.email,
              'avatarUrl': '',
            },
          );
          // String date = '2024-09-09'; // La fecha puede ser dinámica
          DateTime selectedDay = DateTime.now();
          //String date = '2024-09-09'; // La fecha puede ser dinámica
          String date = DateFormat('yyyy-MM-dd').format(selectedDay);
          context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento

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
                      BlocProvider(
                        create: (context) => TasksBloc(tasksRepository: TasksRepository(authService: ApiService())),
                        child: InkWell(
                          onTap: () {
                            DateTime selectedDay = DateTime.now();
                            //String date = '2024-09-09'; // La fecha puede ser dinámica
                            String date = DateFormat('yyyy-MM-dd').format(selectedDay);

                            context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento
                          },
                          child: Text(
                            'Huoon',
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Colors.white,
                                  // Cambia alguna propiedad aqui
                                ),
                          ),
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
      ),
    );
  }
}
