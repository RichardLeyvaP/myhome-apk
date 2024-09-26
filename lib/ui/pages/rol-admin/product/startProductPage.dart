import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/product_cat_state_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_event.dart';
import 'package:myhome/domain/modelos/category_model.dart';
import 'package:myhome/ui/Components/category_widget.dart';
import 'package:provider/provider.dart';

class StartProductPage extends StatefulWidget {
  final PageController pageController;

  StartProductPage({required this.pageController});

  @override
  _StartProductPageState createState() => _StartProductPageState();
}

class _StartProductPageState extends State<StartProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final int initialQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Esto permite que el teclado empuje el contenido
      appBar: AppBar(
        title: Text('Nuevo Producto'),
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
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
                  SizedBox(height: 100),
                  Container()
                ],
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
                      },
                      child: Text("Regresar"),
                    ),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text("Siguiente"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    // if (_formKey.currentState?.validate() ?? false) {
    // Cierra el teclado si está abierto
    FocusScope.of(context).unfocus();
    // Enviar el evento al BLoC

    print('object-test-_titleController.text:${_titleController.text}');
    print('object-test-_descriptionController.text:${_descriptionController.text}');
    final productElement = ProductElement(
      name: _titleController.text, additionalNotes: _descriptionController.text,
      // image: 'products/1.jpg',
    );

// Dispara el evento para insertar el producto
    context.read<ProductsBloc>().add(ProductUpdated(productElement));
    context.read<CategoriesPrioritiesBloc>().add(CategoriesRequested());
    //context.read<ProductsBloc>().add(ProductSubmitted(productElement));//este mando a insertar a la db

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Se está creando el producto...'),

    //     duration: Duration(seconds: 2), // Duración del SnackBar
    //     action: SnackBarAction(
    //       label: 'Aceptar',
    //       onPressed: () {
    //         // Acción a realizar si se presiona el botón
    //       },
    //     ),
    //   ),
    // ); // Pasar la fecha al evento

    // Navegar a la siguiente página
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    //}
  }
}
