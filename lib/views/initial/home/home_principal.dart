import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/Components/showDialogComp.dart';
import 'package:myhome/views/blocs/01-simple_cubit/username_cubit.dart';
import 'package:myhome/views/pageMenu/filesPage.dart';
import 'package:myhome/views/pageMenu/financePage.dart';
import 'package:myhome/views/pageMenu/healthPage.dart';
import 'package:myhome/views/pageMenu/productPage.dart';
import 'package:myhome/views/pageMenu/wishesPage.dart';
import 'package:provider/provider.dart';

import '../../pageMenu/tasksPage.dart';
//COLORES
// color gris de fondo ... Colors.white

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

bool isDark = false;
String search = '';
final ThemeData themeData = ThemeData(useMaterial3: true, brightness: isDark ? Brightness.dark : Brightness.light);

class _HomePrincipalState extends State<HomePrincipal> with SingleTickerProviderStateMixin {
  //esto es para el mapa
  // Controlador de PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;
  ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  // Función para cambiar de página
  void _onButtonPressed(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

  void _onPageChanged(int index) {
    _fetchDataForPage(index);
    setState(() {
      _currentPage = index;
    });
    // Desplazar la Row para que el botón correspondiente esté visible
    double targetScrollOffset = (index * 75.0); // Ajusta este valor al tamaño de tus botones
    _scrollController.animateTo(
      targetScrollOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    // Aquí puedes hacer una llamada a la API según la página
  }

  Future<void> _fetchDataForPage(int pageIndex) async {
    // Lógica para llamar a la API dependiendo de la página
    print('Fetching data for page $pageIndex');
    // Aquí iría tu lógica de llamada a la API
    showLoadingDialog(context, indicatorColor: Colors.white, message: 'Cargando...');
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.of(context).pop();
  }

  List<IconData> _tabIcons = [
    MdiIcons.creationOutline, // Deseos
    MdiIcons.finance, // Finanzas
    MdiIcons.hospitalBoxOutline, // Salud
    MdiIcons.calendarWeekendOutline, //tareas
    MdiIcons.tagOutline, //Productos
    MdiIcons.folderStarOutline, //Archivos
  ];
  final List<String> _tabTexts = ['Deseos', 'Finanzas', 'Salud', 'Tareas', 'Productos', 'Archivos'];

  @override
  void initState() {
    super.initState();
    // _getLocation();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 3);
    _tabController.addListener(() {
      setState(() {});
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //  cLogin.toggleTheme();
      // Aquí puedes poner la lógica que necesitas ejecutar después de que el widget haya sido renderizado
      print("Widget renderizado completamente");
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    print('alto de mi telefono es :$screenHeight');
    final usernameCubit = context.watch<UsernameCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: 195,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  // Text(usernameCubit.state),
                  appBarWidget(MdiIcons.bellOutline, MdiIcons.messageOutline),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: searchWidget(setState),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: cardMenu(_tabController),
                  ),
                ]),
              ),
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    WishesPage(),
                    FinancePage(),
                    HealthPage(),
                    TasksWidget(),
                    ProductPage(),
                    FilesPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StatefulBuilder(
        builder: (context, setState) {
          return InkWell(
            onTap: () {
              dialogComponet(context, _tabTexts[_tabController.index]);
            },
            child: CircleAvatar(
              child: Icon(
                _tabIcons[_tabController.index], // Icono que corresponde al Tab seleccionado
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<dynamic> dialogComponet(BuildContext context, String name) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ), //this right here
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 93, 137, 233),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 150,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 10),
                      child: Text('Cargar formulario de: $name')),
                  //

                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 0, horizontal: 18.0),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF4470F3))),
                          onPressed: () async {
                            if (1 == 1) //codigo 200
                            {
                              //mando notificacion al barbero
                              //quiere decir que el qr esta bloquedo hasta que acepten o rechacen

                              print('solicitud enviada correctamente');
                            }
                            //manadar un mensaje si la solicitud se envio bien

                            Navigator.pop(context);
                            // Cerrar el primer modal
                          },
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Aceptar  ',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

Widget appBarWidget(IconData icon1, IconData icon2) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'huoon',
                        style: TextStyle(
                            color: Color.fromARGB(255, 211, 92, 92), fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Badge(isLabelVisible: true, child: Icon(icon1))),
                  IconButton(onPressed: () {}, icon: Icon(icon2)),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget searchWidget(setState) {
  return SearchAnchor(
    viewBackgroundColor: Colors.white,
    isFullScreen: false, //es si se quiere poner el buscar en la pantalla completa
    builder: (BuildContext context, SearchController controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4), //este es para separa el icono-lupa
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Color.fromARGB(255, 211, 92, 92),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: search.isEmpty ? true : false,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Qué deseas hacer?\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 32, 32),
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Planificar Tareas - Recordatorios - Chat',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(200, 37, 37, 37),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(visible: search.isEmpty ? false : true, child: Text(search))
                ],
              ),
            ),
          ],
        ),
      );
    },
    suggestionsBuilder: (BuildContext context, SearchController controller) {
      final arrayD = ['Chat', 'Crear Lista de compras', 'Organizar Cumpleaños', 'Recordatorios', ''];
      return List<ListTile>.generate(arrayD.length, (int index) {
        final String item = arrayD[index].toString();
        return ListTile(
          title: Text(item),
          onTap: () {
            setState(() {
              controller.closeView(item);
              search = controller.text;
            });
          },
        );
      });
    },
  );
}

Widget cardMenu(_tabController) {
  return Container(
    color: Colors.transparent,
    child: TabBar(
      isScrollable: true, // Permite que el TabBar sea desplazable si hay muchas pestañas
      tabAlignment: TabAlignment.start,
      indicatorColor: const Color.fromARGB(255, 211, 92, 92), // Cambia el color de la barra inferior
      controller: _tabController,
      tabs: [
        Tab(
          child: cardMenuUp(MdiIcons.creationOutline, 'Deseos', _tabController.index == 0),
        ),
        Tab(
          child: cardMenuUp(MdiIcons.finance, 'Finanzas', _tabController.index == 1),
        ),
        Tab(
          child: cardMenuUp(MdiIcons.hospitalBoxOutline, 'Salud', _tabController.index == 2),
        ),
        Tab(
          child: cardMenuUp(MdiIcons.calendarWeekendOutline, 'Tareas', _tabController.index == 3),
        ),
        Tab(
          child: cardMenuUp(MdiIcons.tagOutline, 'Productos', _tabController.index == 4),
        ),
        Tab(
          child: cardMenuUp(MdiIcons.folderStarOutline, 'Archivos', _tabController.index == 5),
        ),
      ],
    ),
  );
}

Column cardMenuUp(IconData icon, String labelText, bool isSelected) {
  return Column(
    children: [
      Icon(
        icon,
        size: 30,
        color: isSelected ? Colors.black : const Color.fromARGB(120, 0, 0, 0),
      ),
      SizedBox(height: 6), // Aumenta la separación
      Text(
        labelText,
        style: TextStyle(
            height: 0.1,
            fontSize: 12,
            color: isSelected ? Colors.black : const Color.fromARGB(120, 0, 0, 0),
            fontWeight: FontWeight.w800),
      ),
    ],
  );
}
