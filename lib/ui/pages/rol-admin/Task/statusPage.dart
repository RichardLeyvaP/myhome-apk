import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';
import 'package:myhome/domain/modelos/category_model.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
  final PageController pageController;

  StatusPage({required this.pageController});
}

class _StatusPageState extends State<StatusPage> {
  int selectedLevel = 0; // Para seleccionar el nivel
  Color colorBotoom = const Color.fromARGB(255, 61, 189, 93);
  Color colorBotoomSel = const Color.fromARGB(255, 199, 64, 59);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado de la tarea'),
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
      body: // Segunda Página
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesStatusPrioritySuccess) {
                    return ListView.builder(
                      itemCount: state.status.length,
                      itemBuilder: (context, index) {
                        final status = state.status[index];
                        return GestureDetector(
                          onTap: () {
                            // Actualizar el estado seleccionado
                            selectedLevel = status.id;
                            context.read<CategoriesStatePrioritiesBloc>().add(SelectStateEvent(status.id));
                          },
                          child: cardSimpleSelection(state, status),
                        );
                      },
                    );
                  } else if (state is CategoriesFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return Container();
                },
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text("Regresar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _onSubmit();
                  },
                  child: Text("Siguiente"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container cardSimpleSelection(CategoriesStatusPrioritySuccess state, Status status) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: state.selectStatetask == status.id ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: state.selectStatetask == status.id ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          status.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: state.selectStatetask == status.id ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    // Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
    // Enviar el evento al BLoC

    //todo ahora esta fijo
    //mandar la prioridad
    context.read<TasksBloc>().add(
          const TaskStatusUpdated(1),
        );

    // Pasar la fecha al evento
    // Usamos Provider.of con listen: false para evitar escuchar cambios en el árbol de widgets

    // Navegar a la siguiente página
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
