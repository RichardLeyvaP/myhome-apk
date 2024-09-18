import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_state.dart';
import 'package:provider/provider.dart';

class StartTaskPage extends StatefulWidget {
  final PageController pageController;

  StartTaskPage({required this.pageController});

  @override
  _StartTaskPageState createState() => _StartTaskPageState();
}

class _StartTaskPageState extends State<StartTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tarea'),
      ),
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0), // Ajusta el valor a tu necesidad
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(MdiIcons.lightbulbQuestionOutline), // Aquí defines el ícono
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300, // Borde gris claro cuando no tiene foco
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue, // Borde azul cuando toma foco
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (_) {
                  _onSubmit();
                },
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300, // Borde gris claro cuando no tiene foco
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // Borde azul cuando toma foco
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                  ),
                ),
                maxLines: 5,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).go('/HomePrincipal');
                    },
                    child: Text("Regresar"),
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: Text("Siguiente"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Cierra el teclado si está abierto
      FocusScope.of(context).unfocus();
      // Enviar el evento al BLoC

      context.read<TasksBloc>().add(
            //aqui agregamos al estado el titulo y la tarea
            TaskTitleDescriptionUpdated(
              _titleController.text,
              _descriptionController.text,
            ),
          ); // Pasar la fecha al evento

      // Navegar a la siguiente página
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
