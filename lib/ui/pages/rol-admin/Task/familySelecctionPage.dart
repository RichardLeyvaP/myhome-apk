import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_state.dart';
import 'package:provider/provider.dart';

class FamilySelectionPage extends StatefulWidget {
  @override
  _FamilySelectionPageState createState() => _FamilySelectionPageState();
  final PageController pageController;

  FamilySelectionPage({required this.pageController});
}

class _FamilySelectionPageState extends State<FamilySelectionPage> {
  List<String> selectedFamilies = [];

  final List<String> families = ['Papá', 'Mamá', 'Hermano', 'Tío', 'Abuelo'];

  void toggleSelection(String family) {
    setState(() {
      if (selectedFamilies.contains(family)) {
        selectedFamilies.remove(family);
      } else {
        selectedFamilies.add(family);
      }
    });
  }

  Color colorBotoom = const Color.fromARGB(255, 61, 189, 93);
  Color colorBotoomSel = const Color.fromARGB(255, 199, 64, 59);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0), // Ajusta el valor a tu necesidad
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(MdiIcons.lightbulbQuestionOutline), // Aquí defines el ícono
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('Selecciona Familiares'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: families.map((family) {
                      bool isSelected = selectedFamilies.contains(family);
                      return GestureDetector(
                        onTap: () => toggleSelection(family),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              family,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
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
        ));
  }

  void _onSubmit() {
    // Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
    // Enviar el evento al BLoC

    // Navegar a la siguiente página
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
