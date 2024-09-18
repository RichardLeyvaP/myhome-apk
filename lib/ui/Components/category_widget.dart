import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final List<Category> categories;
  final String titleWidget;
  final bool selectMultiple;
  final Function(List<Category>) onSelectionChanged; // Callback para devolver categorías seleccionadas

  const CategoryWidget({
    super.key,
    required this.categories,
    required this.titleWidget,
    this.selectMultiple = true,
    required this.onSelectionChanged,
  });

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<bool> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    selectedCategories = List<bool>.filled(widget.categories.length, false);
  }

  // Función para obtener las categorías seleccionadas y notificar a la página principal
  void _notifySelection() {
    List<Category> selected = [];
    for (int i = 0; i < selectedCategories.length; i++) {
      if (selectedCategories[i]) {
        selected.add(widget.categories[i]);
      }
    }
    widget.onSelectionChanged(selected); // Llamar al callback con las categorías seleccionadas
  }
  // Función para mostrar el modal

  void _showAddCategoryDialog() {
    TextEditingController titleController = TextEditingController();
    List<IconItem> iconDataList = [
      IconItem(Icons.sports_basketball, 'sports_basketball'),
      IconItem(Icons.kitchen, 'kitchen'),
      IconItem(Icons.computer, 'computer'),
      IconItem(Icons.brush, 'brush'),
      IconItem(Icons.music_note, 'music_note'),
      IconItem(Icons.flight, 'flight'),
      IconItem(Icons.lightbulb, 'lightbulb'),
      IconItem(Icons.chair, 'chair'),
      IconItem(Icons.bed, 'bed'),
      IconItem(Icons.local_laundry_service, 'local_laundry_service'),
      IconItem(Icons.wifi, 'wifi'),
      IconItem(Icons.thermostat, 'thermostat'),
      IconItem(Icons.tv, 'tv'),
      IconItem(Icons.plumbing, 'plumbing'),
      IconItem(Icons.fireplace, 'fireplace'),
      IconItem(Icons.garage, 'garage'),
      IconItem(Icons.cleaning_services, 'cleaning_services'),
      IconItem(Icons.security, 'security'),
      IconItem(Icons.electrical_services, 'electrical_services'),
      IconItem(Icons.home, 'home'),
    ];

    String? selectedIconName;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Nueva Categoría',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w500
                    // Cambia alguna propiedad aqui
                    ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Campo de texto para el título
                  TextFormField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El título es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  // Íconos con selección
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var iconItem in iconDataList)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIconName = iconItem.iconName;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: selectedIconName == iconItem.iconName
                                              ? const Color.fromARGB(200, 177, 230, 179)
                                              : Colors.grey[300],
                                          child: Icon(
                                            iconItem.iconData,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      if (selectedIconName == iconItem.iconName)
                                        const Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                // Botón para cancelar
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                // Botón para agregar
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    // Aquí puedes manejar el envío de los datos a tu API.
                    String tituloNew = titleController.text;
                    String? iconNew = selectedIconName;
                    print('Nuevo título: $tituloNew, Nuevo ícono: $iconNew');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.titleWidget,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _showAddCategoryDialog, // Muestra el modal al hacer clic
                child: const CircleAvatar(
                  radius: 15,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 112, // Altura total del contenedor (dos filas)
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (widget.categories.length / 2).ceil(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: _buildCategoryContainer(index * 2),
                  ),
                  if ((index * 2) + 1 < widget.categories.length)
                    Expanded(
                      child: _buildCategoryContainer((index * 2) + 1),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Construye cada container de categoría
  Widget _buildCategoryContainer(int index) {
    final category = widget.categories[index];
    final isSelected = selectedCategories[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.selectMultiple) {
            selectedCategories[index] = !isSelected;
          } else {
            selectedCategories = List<bool>.filled(selectedCategories.length, false);
            selectedCategories[index] = true;
          }
          _notifySelection(); // Notificar cuando se cambie la selección
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 85, // Tamaño fijo para cada contenedor
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  category.icon,
                  size: 20,
                  color: Colors.grey[700],
                ),
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (isSelected)
            const Positioned(
              top: 5,
              right: 5,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}

// Modelo de categoría
class Category {
  final String title;
  final IconData icon;
  final int id;

  Category({required this.title, required this.icon, required this.id});
}

class IconItem {
  final IconData iconData;
  final String iconName;

  IconItem(this.iconData, this.iconName);
}
