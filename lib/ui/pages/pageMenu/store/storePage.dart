import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/products/product_model.dart';
import 'package:myhome/data/models/store/store_model.dart';
import 'package:myhome/domain/blocs/product_cat_state/bloc/product_cat_state_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_bloc.dart';
import 'package:myhome/domain/blocs/products_bloc/products_event.dart';
import 'package:myhome/domain/blocs/products_bloc/products_state.dart';
import 'package:myhome/domain/blocs/store_bloc/store_bloc.dart';
import 'package:myhome/domain/blocs/store_bloc/store_event.dart';
import 'package:myhome/domain/blocs/store_bloc/store_state.dart';
import 'package:myhome/ui/util/utils_class_apk.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _showProductDetail = false;
  StoreElement? _selectedStore;

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(const ProductsRequested()); //cargo los productos
    context.read<StoreBloc>().add(const StoreRequested()); //cargo los almacenes
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  // Función para cambiar a la vista de detalles del producto
  void _showProductDetails(StoreElement product) {
    setState(() {
      _selectedStore = product;
      _showProductDetail = true;
    });
  }

  // Función para regresar a la lista de productos
  void _showProductList() {
    setState(() {
      _showProductDetail = false;
      _selectedStore = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Entrando en página de Almacenes');
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, setState) {
          return _selectedStore == null
              ? InkWell(
                  onTap: () {
                    GoRouter.of(context).go(
                      //mando a la vista de crear un nuevo almacen
                      '/StoreCreation',
                    );
                  },
                  child: CircleAvatar(
                    child: Icon(
                      MdiIcons.storeOutline, // Icono que corresponde a insertar almacen
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    context.read<CategoriesPrioritiesBloc>().add(CategoriesRequested());
                    GoRouter.of(context).go(
                      //mando a la vista de crear el producto
                      '/ProductCreation',
                    );
                  },
                  child: CircleAvatar(
                    child: Icon(
                      MdiIcons.tagOutline, // Icono que corresponde a insertar producto
                    ),
                  ),
                );
        },
      ),
      body: Stack(
        children: [
          _showProductDetail && _selectedStore != null
              ? _buildProductListView(_selectedStore!)
              // ? _buildProductDetailView(_selectedStore!)
              : _buildStoreListView(),
          // El contenido principal de tu pantalla
          Positioned(
            bottom: 20,
            left: 5,
            child: StatefulBuilder(
              builder: (context, setState) {
                return AnimatedOpacity(
                  opacity: _selectedStore != null ? 1.0 : 0.0, // Controla la opacidad
                  duration: Duration(milliseconds: 1500), // Duración de la animación
                  curve: Curves.easeInOut, // Curva de la animación
                  child: _selectedStore != null // Si no hay almacén seleccionado, no muestra nada
                      ? InkWell(
                          onTap: () {
                            // Acción al hacer clic
                            _showProductList();
                          },
                          child: CircleAvatar(
                            child: Icon(
                              MdiIcons.arrowLeft, // Icono de flecha hacia la izquierda
                            ),
                          ),
                        )
                      : SizedBox.shrink(), // Si no está visible, ocupa 0 espacio
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductListView(StoreElement selectedStore) {
    print('_buildProductListView-aqui seleccionando el almacen:${selectedStore.name}');
    return Column(
      children: [
        Flexible(
            child: Text(
          selectedStore.name.toString(),
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
        Expanded(
          flex: 4,
          child: BlocBuilder<ProductsBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: StyleGlobalApk.getColorPrimary(),
                  ),
                );
              } else if (state is ProductFailure) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is ProductEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 180),
                    Center(child: Text('${state.message}')),
                  ],
                );
              } else if (state is ProductSuccess) {
                List<ProductElement> products = state.product.products;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: products.map((product) {
                          return buildProductContainer(product.name.toString(), product.image.toString(),
                              product.totalPrice.toString(), product.quantity.toString());
                        }).toList(),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: const Text('No hay estados de productos'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoreListView() {
    return Expanded(
      child: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          print('Entrando en página de-tengo etsado:$state');
          if (state is StoreLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: StyleGlobalApk.getColorPrimary(),
              ),
            );
          } else if (state is StoreFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is StoreEmpty) {
            return Column(
              children: [
                SizedBox(height: 180),
                Center(child: Text('${state.message}')),
              ],
            );
          } else if (state is StoreSuccess) {
            List<StoreElement> stores = state.store.store;

            return SingleChildScrollView(
              child: Column(
                children: stores.map((store) {
                  return GestureDetector(
                    onTap: () => _showProductDetails(store),
                    child: buildStoreContainer(
                        store.name.toString(), store.location.toString(), store.description.toString()),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(child: const Text('No hay almacenes'));
          }
        },
      ),
    );
  }
}

Widget buildProductContainer(String name, String imageUrl, String price, String quantity) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5, // Sombra de la tarjeta para hacerla más llamativa
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          // Imagen del producto en un avatar circular
          CircleAvatar(
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage('assets/default_product_image.png') as ImageProvider,
            radius: 25,
          ),
          const SizedBox(width: 10),
          // Información del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y precio del producto
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
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
                // Cantidad del producto
                Text(
                  'Cantidad: $quantity',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildStoreContainer(String name, String location, String description) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5, // Sombra de la tarjeta para hacerla más llamativa
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nombre del "almacén"
              Expanded(
                child: Text(
                  ' $name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                  softWrap: true, // Permite que el texto se envuelva en múltiples líneas
                  overflow: TextOverflow.ellipsis, // Muestra puntos suspensivos si es muy largo
                ),
              ),
              // Icono o avatar opcional
              Icon(
                Icons.store_mall_directory, // Ícono que puede representar un almacén
                color: Colors.blueGrey[400],
                size: 25,
              ),
            ],
          ),

          const SizedBox(height: 2),
          // Descripción del "almacén"
          Row(
            children: [
              Icon(
                Icons.list_alt,
                color: const Color.fromARGB(255, 90, 138, 94),
                size: 14,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  ' $description',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 117, 117, 117),
                  ),
                  softWrap: true, // Permite que la descripción se ajuste en varias líneas
                  overflow: TextOverflow.ellipsis, // Opcional: agrega puntos suspensivos si es muy largo
                  maxLines: 3, // Puedes limitar la cantidad de líneas si lo deseas
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Ubicación del "almacén"
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 14,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  softWrap: true,
                  maxLines: 2, // Puedes limitar la cantidad de líneas si lo deseas
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
