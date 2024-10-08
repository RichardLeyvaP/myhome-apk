import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/login_bloc/login_bloc.dart';
import 'package:myhome/domain/blocs/login_bloc/login_state.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';
import 'package:myhome/domain/modelos/category_model.dart';
import 'package:myhome/ui/Components/category_widget.dart';
import 'package:provider/provider.dart';

class PriorityPage extends StatefulWidget {
  @override
  _PriorityPageState createState() => _PriorityPageState();
  final PageController pageController;

  PriorityPage({required this.pageController});
}

class _PriorityPageState extends State<PriorityPage> {
  int selectedLevel = 0; // Para seleccionar el nivel
  Color colorBotoom = const Color.fromARGB(255, 61, 189, 93);
  Color colorBotoomSel = const Color.fromARGB(255, 199, 64, 59);

  List<Category> categories = [
    Category(title: 'Deportes', icon: Icons.sports_basketball, id: 1),
    Category(title: 'Cocina', icon: Icons.kitchen, id: 2),
    Category(title: 'Tecnología', icon: Icons.computer, id: 3),
    Category(title: 'Arte', icon: Icons.brush, id: 4),
    Category(title: 'Música', icon: Icons.music_note, id: 5),
    Category(title: 'Viajes', icon: Icons.flight, id: 6),
    Category(title: 'Deportes2', icon: Icons.sports_basketball, id: 7),
    Category(title: 'Cocina3', icon: Icons.kitchen, id: 8),
    Category(title: 'Tecnología5', icon: Icons.shop, id: 9),
    Category(title: 'Arte4', icon: Icons.brush, id: 10),
    Category(title: 'Música3', icon: Icons.music_note, id: 11),
    Category(title: 'Viajes4', icon: Icons.flight, id: 12),
  ];
  List<int> arrayCategory = [1]; // Inicializamos la cantidad seleccionada
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prioridad'),
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
            // Primera mitad de la pantalla, con scroll si es necesario
            Expanded(
              flex: 1,
              child: BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesStatusPrioritySuccess) {
                    return ListView.builder(
                      itemCount: state.priority.length,
                      itemBuilder: (context, index) {
                        final status = state.priority[index];
                        return GestureDetector(
                          onTap: () {
                            // Actualizar el estado seleccionado
                            selectedLevel = status.id;
                            context.read<CategoriesStatePrioritiesBloc>().add(SelectedPriorityIdEvent(status.id));
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

            // Espaciado entre las secciones
            SizedBox(height: 20),

            // Segunda mitad de la pantalla
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // El segundo BlocBuilder para mostrar las categorías
                  BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesStatusPrioritySuccess) {
                        if (state.categories.isNotEmpty && state.selectedCategoryId == null) {
                          context
                              .read<CategoriesStatePrioritiesBloc>()
                              .add(CategoryTaskSelectedEvent(state.categories[0].id));
                        }

                        return CategoryWidget(
                          categories: state.categories,
                          titleWidget: 'Categoría',
                          selectedCategoryId: state.selectedCategoryId,
                          selectMultiple: false,
                          onSelectionChanged: (selectedCategories) {
                            setState(() {
                              arrayCategory = selectedCategories
                                  .asMap()
                                  .entries
                                  .map((entry) => selectedCategories[entry.key].id)
                                  .toList();
                            });
                          },
                        );
                      } else if (state is CategoriesFailure) {
                        return Center(child: Text('Error: ${state.error}'));
                      }
                      return Container();
                    },
                  ),

                  Spacer(),

                  // Botones de navegación
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
          ],
        ),
      ),
    );
  }

  Container cardSimpleSelection(CategoriesStatusPrioritySuccess state, Priority status) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: state.selectedPriorityId == status.id ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color:
                state.selectedPriorityId == status.id ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
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
            color: state.selectedPriorityId == status.id ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    // Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
    // Enviar el evento al BLoC
    final loginState = context.read<LoginBloc>().state;

    String? token;
    if (loginState is LoginSuccess) {
      token = loginState.user.token;
    }
    print('el token es:$token');

    //todo ahora esta fijo
    //mandar la prioridad
    context.read<TasksBloc>().add(
          const TaskPriorityUpdated(1),
        );

    // Navegar a la siguiente página
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
