import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/Components/avatarMultiples.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Text(usernameCubit.state),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: cardContentHome(context, 'Compras en el Supermecado', Icons.content_cut, 'SERVICIOS', 'sds', 'sd',
              12.0, Colors.blue, 2, 8, 12, const Color.fromARGB(40, 133, 175, 209)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: cardContentHome(context, 'Richard', Icons.content_cut, 'SERVICIOS', 'sds', 'sd', 12.0, Colors.red, 2,
              10, 12, const Color.fromARGB(100, 221, 220, 220)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: cardContentHome(context, 'Cumpleaños de Clara', Icons.content_cut, 'SERVICIOS', 'sds', 'sd', 12.0,
              const Color.fromARGB(255, 61, 189, 93), 2, 10, 12, const Color.fromARGB(100, 221, 220, 220)),
        ),
      ]),
    );
  }
}

Widget cardContentHome(context, String title, IconData icon, String labelText, String labelTime, String labelPrice,
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
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: colorBotoom, fontWeight: FontWeight.bold // Cambia alguna propiedad aqui
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
                                Text(
                                  'Lunes',
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      // Cambia alguna propiedad aqui
                                      ),
                                ),
                                Text(
                                  '22',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: colorBotoom, // Cambia el color del texto aquí
                                      ),
                                ),
                                Text(
                                  'Julio',
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 0.5
                                      // Cambia alguna propiedad aqui
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
                                child: Row(
                                  children: [
                                    Icon(Icons.list, color: Colors.black), // Icono de lista
                                    SizedBox(width: 4.0), // Espacio entre el icono y el texto
                                    Text(
                                      'Listas de compras',
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                          // Cambia alguna propiedad aqui
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.blue // Cambia alguna propiedad aqui
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
                                    Icon(Icons.support_agent, color: Colors.red), // Icono de dinero
                                    SizedBox(width: 4.0), // Espacio entre el icono y el texto
                                    Text(
                                      'Sugerencias',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.red // Cambia alguna propiedad aqui
                                              ),
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
