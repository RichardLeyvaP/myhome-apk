import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/domain/blocs/products_bloc/products_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_event.dart';
import 'package:myhome/domain/blocs/products_bloc/products_state.dart';
import 'package:myhome/ui/util/utils_class_apk.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Inicializamos el primer día con algún contenido

    context.read<ProductsBloc>().add(const ProductsRequested());
    //_updateEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    print('entrando aqui pagina productos');
    return Scaffold(
      body: Expanded(
        child: BlocBuilder<ProductsBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              // Mostrar un indicador de carga mientras se obtienen las tareas
              return Center(
                  child: CircularProgressIndicator(
                color: StyleGlobalApk.getColorPrimary(),
              ));
            } else if (state is ProductFailure) {
              // Mostrar un mensaje de error en caso de falla
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is ProductEmpty) {
              // Mostrar mensaje si no hay tareas para ese día
              return Column(
                children: [
                  SizedBox(height: 180),
                  Center(child: Text('${state.message}')),
                ],
              );
            } else if (state is ProductSuccess) {
              List<ProductElement> tasks = state.product.products; // Asegúrate que sea una lista de tareas

              // Construir la lista de `CardTasks` dependiendo de la longitud de las tareas
              return SingleChildScrollView(
                child: Column(
                  children: tasks.map((product) {
                    return buildProductContainer(
                        product.name.toString(), product.image.toString(), product.unitPrice.toString());
                  }).toList(),
                ),
              );
            } else {
              // Retorna un widget vacío en caso de que no coincida ningún estado
              return Center(child: const Text('No hay estados de productos'));
              // return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

Widget buildProductContainer(String name, String imageUrl, String price) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Avatar con la imagen del producto
        CircleAvatar(
          backgroundImage: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : AssetImage('assets/default_product_image.png') as ImageProvider,
          radius: 30,
        ),
        const SizedBox(width: 10),
        // Información del producto
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
