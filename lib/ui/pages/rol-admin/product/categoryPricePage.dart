import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/domain/blocs/products_bloc/products_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_event.dart';
import 'package:myhome/ui/Components/category_widget.dart';
import 'package:myhome/ui/pages/rol-admin/Task/selectDays/utils.dart';
import 'package:provider/provider.dart';

class CategoryPricePage extends StatefulWidget {
  @override
  _CategoryPricePageState createState() => _CategoryPricePageState();
  final PageController pageController;

  CategoryPricePage({required this.pageController});
}

class _CategoryPricePageState extends State<CategoryPricePage> {
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
  final TextEditingController _priceController = TextEditingController();
  final int initialQuantity = 1;
  final TextEditingController _marcaController = TextEditingController();

  int selectedQuantity = 1;

  List<int> arrayCategory = [1]; // Inicializamos la cantidad seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del producto'),
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
            SizedBox(height: 20),
            TextFormField(
              controller: _marcaController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Marca',
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
            SizedBox(height: 20),
            Row(
              children: [
                // Usamos Expanded para que el TextField tome el espacio disponible
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre los dos widgets
                QuantitySelector(
                  initialQuantity: selectedQuantity,
                  onQuantityChanged: (newQuantity) {
                    // Actualizamos el estado con la cantidad seleccionada
                    setState(() {
                      selectedQuantity = newQuantity;
                    });
                  },
                ),
              ],
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
    print('object-test-_marcaController.text:${_marcaController.text}');
    print('object-test-arrayCategory:$arrayCategory');
    print('object-test-_priceController.text:${_priceController.text}');
    print('object-test-selectedQuantity:$selectedQuantity');

    //todo ahora esta fijo
    final productElement = ProductElement(
        brand: _marcaController.text,
        categoryId: arrayCategory[0],
        unitPrice: _priceController.text,
        quantity: selectedQuantity
        // image: 'products/1.jpg',
        );
// Dispara el evento para insertar el producto
    context.read<ProductsBloc>().add(ProductUpdated(productElement));

    // Navegar a la siguiente página
    widget.pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
