import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StartTaskPage extends StatefulWidget {
  @override
  _StartTaskPageState createState() => _StartTaskPageState();
  final PageController pageController;

  StartTaskPage({required this.pageController});
}

class _StartTaskPageState extends State<StartTaskPage> {
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
      body: // Primera Página
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextField(
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
                  borderSide: BorderSide(
                    color: Colors.blue, // Borde azul cuando toma foco
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Borde redondeado
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) {
                _sigForm();
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
                    GoRouter.of(context).go(
                      '/HomePrincipal',
                    );
                    //  Navigator.pop(context);
                  },
                  child: Text("Regresar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _sigForm();
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

  void _sigForm() {
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
