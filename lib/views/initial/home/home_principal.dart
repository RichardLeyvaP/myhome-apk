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

class _HomePrincipalState extends State<HomePrincipal> {
  //esto es para el mapa
  // Controlador de PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;
  ScrollController _scrollController = ScrollController();

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

  @override
  void initState() {
    super.initState();
    // _getLocation();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //  cLogin.toggleTheme();
      // Aquí puedes poner la lógica que necesitas ejecutar después de que el widget haya sido renderizado
      print("Widget renderizado completamente");
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernameCubit = context.watch<UsernameCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                flex: 22,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  // Text(usernameCubit.state),
                  appBarWidget(MdiIcons.bellOutline, MdiIcons.messageOutline),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: searchWidget(setState),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: cardMenu(_scrollController, _currentPage, _onButtonPressed, Icons.content_cut, 'SERVICIOS',
                        'sds', 'sd', 0.0),
                  ),
                ]),
              ),
              Expanded(
                  flex: 70,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: const [
                      WishesPage(),
                      FinancePage(),
                      HealthPage(),
                      TasksWidget(),
                      ProductPage(),
                      FilesPage(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
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

Widget cardMenu(_scrollController, _currentPage, _onButtonPressed, IconData icon, String labelText, String labelTime,
    String labelPrice, double edgeInsets) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(), //el primero 0 margen
            child: cardMenuUp(_onButtonPressed, MdiIcons.autoFix, 'Deseos', 0, _currentPage == 0),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(_onButtonPressed, MdiIcons.finance, 'Finanzas', 1, _currentPage == 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(_onButtonPressed, MdiIcons.hospitalBoxOutline, 'Salud', 2, _currentPage == 2),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(_onButtonPressed, MdiIcons.calendarWeekendOutline, 'Tareas', 3, _currentPage == 3),
            //cardMenuUp(MdiIcons.clipboardEditOutline, 'Tareas', 4, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(_onButtonPressed, MdiIcons.tagOutline, 'Productos', 4, _currentPage == 4),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(
                _onButtonPressed, MdiIcons.folderStarOutline, 'Archivos', 5, _currentPage == 5), //el ultimo sejo margen
          ),
        ],
      ),
    ),
  );
}

Column cardMenuUp(_onButtonPressed, IconData icon, String labelText, int value, bool visibility) {
  return Column(
    children: [
      ElevatedButton(
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            // padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            //   const EdgeInsets.symmetric(
            //       vertical: 16.0, horizontal: 0.0), // Ajusta el padding
            // ),
            backgroundColor: WidgetStateProperty.all<Color>(
              Colors.white,
            ),

            // Añadir más propiedades de estilo aquí
          ),
          onPressed: () async {
            _onButtonPressed(value);

            //  cNavig.setSelectMenu(value);
          },
          child: Icon(
            icon,
            size: 30,
            color: visibility ? const Color.fromARGB(180, 0, 0, 0) : const Color.fromARGB(120, 0, 0, 0),
          )),
      Text(
        labelText,
        style: TextStyle(
            height: 0.1,
            fontSize: 12,
            color: visibility ? Color.fromARGB(180, 0, 0, 0) : Color.fromARGB(120, 0, 0, 0),
            fontWeight: FontWeight.w800),
      ),
      const SizedBox(
        height: 8,
      ),
      Visibility(
        visible: visibility,
        child: Container(
          height: 3,
          width: 64,
          color: const Color.fromARGB(255, 211, 92, 92),
        ),
      )
    ],
  );
}
