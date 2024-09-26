import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FamilySelectionPage extends StatefulWidget {
  @override
  _FamilySelectionPageState createState() => _FamilySelectionPageState();
  final PageController pageController;

  FamilySelectionPage({required this.pageController});
}

class _FamilySelectionPageState extends State<FamilySelectionPage> {
  List<String> selectedFamilies = [];

  final List<String> families = ['Papá', 'Mamá', 'Hermano', 'Tío', 'Abuelo'];
  final List<String> familiesName = ['Richard Leyva', 'Raciel Leyva', 'Yennis Leyva', 'Pacho Pérez', 'Nerza de León'];

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
  int i = 0;
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
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://tse4.mm.bing.net/th?id=OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH&pid=Api&P=0&h=180'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    family,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    familiesName[0],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
