import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/ui/Components/avatarMultiples.dart';

class CardTasks extends StatelessWidget {
  final String title;
  final IconData icon;
  final String date;
  final String details;
  final String schedule;
  final double iconSize;
  final Color iconColor;
  final double? padding;
  final double? radius;

  const CardTasks({
    Key? key,
    required this.title,
    required this.icon,
    required this.date,
    required this.details,
    required this.schedule,
    required this.iconSize,
    required this.iconColor,
    this.padding,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity, // Ocupa el 100% del ancho disponible
        decoration: BoxDecoration(
          color: Colors.white, // Color de fondo del contenedor
          borderRadius: BorderRadius.circular(radius ?? 26), // Esquinas redondeadas
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
          height: 90,
          width: double.infinity, // Ocupa el 100% del ancho disponible
          //padding: const EdgeInsets.all(8.0), // Espaciado interno opcional
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(radius ?? 26), // Esquinas redondeadas
          ),
          child: Padding(
            padding: EdgeInsets.all(padding ?? 6),
            child: Container(
              decoration: BoxDecoration(
                  //  color: const Color.fromARGB(111, 173, 173, 171),
                  // border: Border(bottom: BorderSide(width: 2, color: Colors.red)), // Esquinas redondeadas
                  ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(radius ?? 26), // Esquinas redondeadas
                    ),

                    width: 75, // Ancho fijo
                    //color: Colors.blue,
                    height: double.infinity, // Ajusta la altura según sea necesario

                    child: Center(
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  // Cambia alguna propiedad aqui
                                  ),
                            ),
                            Text(
                              schedule,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  // Cambia alguna propiedad aqui
                                  ),
                            ), // Icono de lista
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                //aqui caben maxiomo 4, idela que fueran 3
                                botonCartTask(
                                  Colors.red,
                                  MdiIcons.robotAngryOutline,
                                ),
                                botonCartTask(Colors.blue, MdiIcons.listBoxOutline),
                                botonCartTask(const Color.fromARGB(255, 145, 243, 33), null),
                                //botonCartTask(const Color.fromARGB(255, 184, 127, 22), null),
                              ],
                            ),
                            const Expanded(
                              child: AvatarMultiple(), // Reemplaza el segundo CircleAvatar con tu widget
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Padding botonCartTask(Color colorBotoom, IconData? icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 2, right: 3, left: 3),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(16), // Esquinas redondeadas
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
          child: icon != null
              ? Icon(
                  icon,
                  size: 25,
                )
              : Container(
                  height: 25,
                  width: 25,
                )),
    ),
  );
}
