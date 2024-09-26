import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_state.dart';
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
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLevel = 1;
                });
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  border: Border.all(
                    color: selectedLevel == 1
                        ? colorBotoomSel.withOpacity(0.8)
                        : colorBotoom.withOpacity(0.4), // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: selectedLevel == 1
                          ? colorBotoomSel.withOpacity(0.4)
                          : colorBotoom.withOpacity(0.4), // Sombra roja
                      spreadRadius: 0, // Asegura que la sombra esté en el borde
                      blurRadius: 10, // Difumina la sombra
                      offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
                    ),
                  ],
                ),
                child: Center(child: Text("Alta")),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLevel = 2;
                });
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  border: Border.all(
                    color: selectedLevel == 2
                        ? colorBotoomSel.withOpacity(0.8)
                        : colorBotoom.withOpacity(0.4), // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: selectedLevel == 2
                          ? colorBotoomSel.withOpacity(0.4)
                          : colorBotoom.withOpacity(0.4), // Sombra roja
                      spreadRadius: 0, // Asegura que la sombra esté en el borde
                      blurRadius: 10, // Difumina la sombra
                      offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
                    ),
                  ],
                ),
                child: Center(child: Text("Media")),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedLevel = 3;
                });
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  border: Border.all(
                    color: selectedLevel == 3
                        ? colorBotoomSel.withOpacity(0.8)
                        : colorBotoom.withOpacity(0.4), // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: selectedLevel == 3
                          ? colorBotoomSel.withOpacity(0.4)
                          : colorBotoom.withOpacity(0.4), // Sombra roja
                      spreadRadius: 0, // Asegura que la sombra esté en el borde
                      blurRadius: 10, // Difumina la sombra
                      offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
                    ),
                  ],
                ),
                child: Center(child: Text("Normal")),
              ),
            ),
            SizedBox(height: 20),
            CategoryWidget(
              categories: categories,
              titleWidget: 'Categoría',
              selectMultiple: false,
              onSelectionChanged: (selectedCategories) {
                setState(() {
                  arrayCategory = selectedCategories
                      .asMap()
                      .entries
                      .map((entry) => selectedCategories[entry.key].id) // Mapea los IDs de las categorías
                      .toList();
                });
              },
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

  void _onSubmit() {
    // Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
    // Enviar el evento al BLoC

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
