import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/store/store_model.dart';
import 'package:myhome/domain/blocs/store_bloc/store_bloc.dart';
import 'package:myhome/domain/blocs/store_bloc/store_event.dart';
import 'package:myhome/domain/blocs/store_bloc/store_state.dart';
import 'package:myhome/ui/pages/rol-admin/Task/selectDays/utils.dart';
import 'package:provider/provider.dart';

class StartStorePage extends StatefulWidget {
  final PageController pageController;

  const StartStorePage({super.key, required this.pageController});

  @override
  _StartStorePageState createState() => _StartStorePageState();
}

class _StartStorePageState extends State<StartStorePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final int initialQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Esto permite que el teclado empuje el contenido
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Nuevo Almacén'),
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
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          String titleState = '';
          if (state is StoreSubmittedUpdated) {
            _titleController.text = state.storeElement.name.toString();
            _descriptionController.text = state.storeElement.description.toString();
            _placeController.text = state.storeElement.location.toString();
          }
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
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
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _placeController,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (_) {
                            _onSubmit();
                          },
                          decoration: InputDecoration(
                            labelText: 'Lugar',
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
                          maxLines: 2,
                        ),
                        SizedBox(height: 100),
                        Container()
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).go('/HomePrincipal');
                            //GoRouter.of(context).pop();
                          },
                          child: Text("Regresar"),
                        ),
                        ElevatedButton(
                          onPressed: _onSubmit,
                          child: Text("Crear"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() == true && !emptyTextField(_titleController.text)) {
      // Cierra el teclado si está abierto
      FocusScope.of(context).unfocus();
      // Enviar el evento al BLoC

      print('object-test-_titleController.text:${_titleController.text}');
      print(
          'object-test-_descriptionController.text:${emptyTextField(_descriptionController.text) ? 'No hay comentario' : _descriptionController.text}');
      final storeElement = StoreElement(
          name: _titleController.text, //si emptyTextField = true es que esta vacio
          description: emptyTextField(_descriptionController.text) ? 'No hay comentario' : _descriptionController.text,
          location: _placeController.text
          // image: 'products/1.jpg',
          );

// Dispara el evento para insertar el producto
      context.read<StoreBloc>().add(StoreUpdated(storeElement));

      // Navegar a la siguiente página
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    if (emptyTextField(_titleController.text)) {
      _titleController.text = '';
    }
  }
}
