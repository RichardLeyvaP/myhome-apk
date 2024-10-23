import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/product_cat_state_bloc.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/modelos/category_model.dart';

class CategoryWidget extends StatefulWidget {
  final List<Category> categories;
  final String titleWidget;
  final bool selectMultiple;
  final Function(List<Category>) onSelectionChanged; // Callback para devolver categorías seleccionadas
  final int? selectedCategoryId; // Agregar el ID de categoría seleccionada

  const CategoryWidget({
    super.key,
    required this.categories,
    required this.titleWidget,
    this.selectMultiple = true,
    required this.onSelectionChanged,
    this.selectedCategoryId, // Recibir el ID de categoría seleccionada
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

    // Establecer el estado inicial con el ID de categoría seleccionada
    if (widget.selectedCategoryId != null) {
      int selectedIndex = widget.categories.indexWhere((category) => category.id == widget.selectedCategoryId);
      if (selectedIndex != -1) {
        selectedCategories[selectedIndex] = true; // Marcar la categoría como seleccionada
      }
    }
  }

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
    // (El código del diálogo se mantiene igual)
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
          height: 118, // Altura total del contenedor (dos filas)
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

  Widget _buildCategoryContainer(int index) {
    final category = widget.categories[index];
    final isSelected = selectedCategories[index];
    print('*** **** *** - ${category.title.length}');
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

          // Despachar evento al Bloc
          // context.read<CategoriesPrioritiesBloc>().add(CategorySelectedEvent(category.id));
          // context.read<CategoriesStatePrioritiesBloc>().add(CategoryTaskSelectedEvent(category.id));
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110, // Tamaño fijo para cada contenedor
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
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

class IconItem {
  final IconData iconData;
  final String iconName;

  IconItem(this.iconData, this.iconName);
}
