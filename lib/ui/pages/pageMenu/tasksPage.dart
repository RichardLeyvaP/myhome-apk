import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/ui/Components/avatarMultiples.dart';
import 'package:myhome/ui/pages/initial/Task/selectDays/calendar.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Text(usernameCubit.state),
        HorizontalCalendar(),
        Padding(
          padding: const EdgeInsets.only(top: 6), //el primero que no tenga margen
          child: cardContentHome(context, 'Compras en el Supermecado', MdiIcons.cartOutline, 'SERVICIOS', 'sds', 'sd',
              12.0, Colors.blue, 8, 14, const Color.fromARGB(40, 133, 175, 209)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: cardContentHome(context, 'Consulta Médica', MdiIcons.hospitalBoxOutline, 'SERVICIOS', 'sds', 'sd',
              12.0, Colors.red, 8, 14, const Color.fromARGB(100, 221, 220, 220)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: cardContentHome(context, 'Cumpleaños de Clara', MdiIcons.cakeVariantOutline, 'SERVICIOS', 'sds', 'sd',
              12.0, const Color.fromARGB(255, 61, 189, 93), 8, 14, const Color.fromARGB(100, 221, 220, 220)),
        ),
      ]),
    );
  }
}

Widget cardContentHome(context, String title, IconData icon, String labelText, String labelTime, String labelPrice,
    double edgeInsets, Color colorBotoom, double paddingT, double radiusCont, Color colorItem) {
  return Card(
    color: Colors.transparent,
    elevation: 0,
    child: Container(
      width: double.infinity, // Ocupa el 100% del ancho disponible
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(radiusCont), // Esquinas redondeadas
        border: Border.all(
          color: const Color.fromARGB(40, 158, 158, 158).withOpacity(0.28), // Color del borde
          width: 2.0, // Grosor del borde
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(120, 158, 158, 158).withOpacity(0.4), // Sombra roja
            spreadRadius: 0, // Asegura que la sombra esté en el borde
            blurRadius: 6, // Difumina la sombra
            offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
          ),
        ],
      ),
      child: Container(
        width: double.infinity, // Ocupa el 100% del ancho disponible
        //padding: const EdgeInsets.all(8.0), // Espaciado interno opcional
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusCont), // Esquinas redondeadas
        ),
        child: Padding(
          padding: EdgeInsets.only(top: paddingT, right: paddingT, left: paddingT, bottom: paddingT),
          child: Row(
            children: [
              Container(
                  width: 70, // Ancho fijo
                  // height: 100, // Ajusta la altura según sea necesario

                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          //padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: colorBotoom.withOpacity(0.3), // Color de fondo gris claro
                            borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Icon(
                                icon,
                                color: colorBotoom,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  //height: 100, // Ajusta la altura según sea necesario

                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                // Cambia alguna propiedad aqui
                                ),
                          ),
                          Text(
                            '10:00 - 12:00',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                // Cambia alguna propiedad aqui
                                ),
                          ), // Icono de lista
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              botonCartTask(Colors.red, Icon(MdiIcons.robotAngryOutline)),
                              SizedBox(
                                width: 8,
                              ),
                              botonCartTask(Colors.blue, Icon(MdiIcons.listBoxOutline)),
                            ],
                          ),
                          Expanded(
                            child: AvatarMultiple(), // Reemplaza el segundo CircleAvatar con tu widget
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Container botonCartTask(Color colorBotoom, Icon icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // Color de fondo del contenedor
      borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
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
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: icon,
    ),
  );
}
