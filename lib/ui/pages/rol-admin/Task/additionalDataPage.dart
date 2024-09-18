import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks_bloc/tasks_event.dart';
import 'package:myhome/ui/pages/rol-admin/Task/selectDays/utils.dart';
import 'package:provider/provider.dart';

class AdditionalDataPage extends StatefulWidget {
  final PageController pageController;

  const AdditionalDataPage({super.key, required this.pageController});

  @override
  _AdditionalDataPageState createState() => _AdditionalDataPageState();
}

class _AdditionalDataPageState extends State<AdditionalDataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otros datos'),
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
              Text('Tiempo estimado(select horas y minutos)'),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (_) {
                  _onSubmit();
                },
                decoration: InputDecoration(
                  labelText: 'Comentarios o notas',
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
              SizedBox(height: 20),
              FilePickerButton(),
              SizedBox(height: 20),
              Text('Geocalización'),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Cierra el teclado si está abierto
                      FocusScope.of(context).unfocus();
                      widget.pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
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

      // Pasar la fecha al evento

      // Navegar a la siguiente página
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
