import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/Components/avatarMultiples.dart';
import 'package:myhome/views/blocs/01-simple_cubit/username_cubit.dart';
import 'package:provider/provider.dart';
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
                    child: cardMenu(Icons.content_cut, 'SERVICIOS', 'sds', 'sd', 0.0),
                  ),
                ]),
              ),
              Expanded(
                flex: 70,
                child: SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    // Text(usernameCubit.state),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: cardContentHome('Compras en el Supermecado', Icons.content_cut, 'SERVICIOS', 'sds', 'sd',
                          12.0, Colors.blue, 2, 8, 12, const Color.fromARGB(40, 133, 175, 209)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: cardContentHome('Richard', Icons.content_cut, 'SERVICIOS', 'sds', 'sd', 12.0, Colors.red,
                          2, 10, 12, const Color.fromARGB(100, 221, 220, 220)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: cardContentHome('Cumpleaños de Clara', Icons.content_cut, 'SERVICIOS', 'sds', 'sd', 12.0,
                          const Color.fromARGB(255, 61, 189, 93), 2, 10, 12, const Color.fromARGB(100, 221, 220, 220)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget appBarWidget(IconData icon, IconData icon2) {
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
                  IconButton(onPressed: () {}, icon: Badge(isLabelVisible: true, child: Icon(icon))),
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

  // SearchAnchor(
  //   viewBackgroundColor: Colors.white,
  //   isFullScreen: false,
  //   builder: (BuildContext context, SearchController controller) {
  //     return SearchBar(
  //       backgroundColor: const WidgetStatePropertyAll(
  //           Color.fromARGB(255, 230, 228, 228)),
  //       controller: controller,
  //       padding: const WidgetStatePropertyAll<EdgeInsets>(
  //           EdgeInsets.all(0.0)), // Eliminar padding externo
  //       leading: const Padding(
  //         padding: EdgeInsets.all(4), // Eliminar padding interno
  //         child: CircleAvatar(
  //           radius: 24, // Ajusta el tamaño del avatar según sea necesario
  //           backgroundColor: Color.fromARGB(255, 211, 92, 92),
  //           child: Icon(
  //             Icons.search,
  //             color: Colors.white,
  //             size: 24, // Tamaño del icono dentro del avatar
  //           ),
  //         ),
  //       ),
  //       hintText:
  //           '¿Qué deseas hacer?\nCrear una receta, chat, planificar tareas...',
  //     );
  //   },
  //   suggestionsBuilder:
  //       (BuildContext context, SearchController controller) {
  //     return List<ListTile>.generate(5, (int index) {
  //       final String item = 'buscar $index';
  //       return ListTile(
  //         title: Text(item),
  //         onTap: () {
  //           setState(() {
  //             controller.closeView(item);
  //           });
  //         },
  //       );
  //     });
  //   },
  // ));
}

Widget cardMenu(IconData icon, String labelText, String labelTime, String labelPrice, double edgeInsets) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(), //el primero 0 margen
            child: cardMenuUp(MdiIcons.autoFix, 'Deseos', 1, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(MdiIcons.finance, 'Finanzas', 2, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(MdiIcons.hospitalBoxOutline, 'Salud', 3, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(MdiIcons.calendarWeekendOutline, 'Tareas', 4, true),
            //cardMenuUp(MdiIcons.clipboardEditOutline, 'Tareas', 4, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(MdiIcons.tagOutline, 'Productos', 5, false),
          ),
          Padding(
            padding: EdgeInsets.only(left: edgeInsets, right: edgeInsets),
            child: cardMenuUp(MdiIcons.folderStarOutline, 'Archivos', 7, false), //el ultimo sejo margen
          ),
        ],
      ),
    ),
  );
}

Column cardMenuUp(IconData icon, String labelText, int value, bool visibility) {
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
            //  cNavig.setSelectMenu(value);
          },
          child: Icon(
            icon,
            size: 30,
            color: const Color.fromARGB(120, 0, 0, 0),
          )),
      Text(
        labelText,
        style: const TextStyle(
            height: 0.1, fontSize: 12, color: Color.fromARGB(120, 0, 0, 0), fontWeight: FontWeight.w800),
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

Widget cardContentHome(String title, IconData icon, String labelText, String labelTime, String labelPrice,
    double edgeInsets, Color colorBotoom, double paddingT, double paddingRL, double radiusCont, Color colorItem) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: double.infinity, // Ocupa el 100% del ancho disponible
          decoration: BoxDecoration(
            color: Colors.white, // Color de fondo del contenedor
            borderRadius: BorderRadius.circular(radiusCont + 2), // Esquinas redondeadas
            border: Border.all(
              color: colorBotoom.withOpacity(0.28), // Color del borde
              width: 2.0, // Grosor del borde
            ),
            boxShadow: [
              BoxShadow(
                color: colorBotoom.withOpacity(0.4), // Sombra roja
                spreadRadius: 0, // Asegura que la sombra esté en el borde
                blurRadius: 10, // Difumina la sombra
                offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
              ),
            ],
          ),
          child: Container(
            width: double.infinity, // Ocupa el 100% del ancho disponible
            //padding: const EdgeInsets.all(8.0), // Espaciado interno opcional
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusCont + 2), // Esquinas redondeadas
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: paddingT, right: paddingRL, left: paddingRL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinea los elementos a la izquierda
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 52, 61, 78), // Texto en negro
                              fontSize: 12.0, // Tamaño de la fuente ajustable
                              fontWeight: FontWeight.bold, // Opcional: estilo de texto en negrita
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                MdiIcons.clock, // Icono de reloj
                                color: colorBotoom, // Color azul para el icono
                              ),
                              const SizedBox(width: 4.0), // Espacio entre el icono y el texto
                              Text(
                                '10:00',
                                style: TextStyle(
                                    color: colorBotoom, // Texto en azul
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold // Tamaño de la fuente ajustable
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0), // Espacio entre la fila superior y el contenido inferior
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Alinea los elementos en la parte superior
                        children: [
                          Container(
                            width: 110,
                            //padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: colorItem, // Color de fondo gris claro
                              borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Lunes',
                                  style: TextStyle(
                                    height: 0.5,
                                    color: Colors.black, // Texto en negro
                                    fontSize: 12.0, // Tamaño más pequeño para el mes
                                  ),
                                ),
                                Text(
                                  '22',
                                  style: TextStyle(
                                    // fontFamily: 'Rakkas',
                                    fontFamily: 'Roboto',
                                    color: colorBotoom, // Texto en negro
                                    fontSize: 46.0, // Tamaño grande para el número
                                    fontWeight: FontWeight.w900, // Estilo más negrita
                                  ),
                                ),
                                const Text(
                                  'Julio',
                                  style: TextStyle(
                                    height: 0.5,
                                    color: Colors.black, // Texto en negro
                                    fontSize: 12.0, // Tamaño más pequeño para el mes
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0), // Margen de 10px entre los dos bloques
                          Container(
                            width: 2,
                            height: 108, //tamaño del separador
                            color: const Color.fromARGB(155, 134, 134, 134),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0), //
                                decoration: BoxDecoration(
                                  color: colorItem, // Color de fondo gris claro
                                  borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.list, color: Colors.black), // Icono de lista
                                    SizedBox(width: 4.0), // Espacio entre el icono y el texto
                                    Text(
                                      'Listas de compras',
                                      style: TextStyle(
                                        color: Colors.black, // Texto en negro
                                        fontSize: 10.0, // Tamaño de la fuente ajustable
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text('  '),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6.0), // Espacio entre las filas de texto
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: colorItem, // Color de fondo gris claro
                                  borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.attach_money, color: colorBotoom), // Icono de dinero
                                    const SizedBox(width: 4.0), // Espacio entre el icono y el texto
                                    Text(
                                      '1.346.00',
                                      style: TextStyle(
                                        color: colorBotoom, // Texto en azul
                                        fontSize: 10.0, // Tamaño de la fuente ajustable
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text('  '),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6.0), // Espacio entre las filas de texto
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: colorItem, // Color de fondo gris claro
                                  borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.support_agent, color: Colors.red), // Icono de dinero
                                    SizedBox(width: 4.0), // Espacio entre el icono y el texto
                                    Text(
                                      'Sugerencias',
                                      style: TextStyle(
                                          color: Colors.red, // Texto en azul
                                          fontSize: 10.0, // Tamaño de la fuente ajustable
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('  '),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity, // Ocupa el 100% del ancho disponible
                  height: 60,
                  // Espaciado interno opcional
                  decoration: BoxDecoration(
                    color: colorBotoom,
                    border: Border.all(
                      color: colorBotoom, // Color del borde
                      //width: 2.0, // Grosor del borde
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusCont),
                        bottomRight: Radius.circular(radiusCont)), // Esquinas redondeadas
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            MdiIcons.cartOutline,
                            color: colorBotoom,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: AvatarMultiple(), // Reemplaza el segundo CircleAvatar con tu widget
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
