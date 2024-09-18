// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

//subida de archivo
//******************* */

// Esta función se llamará cuando el usuario presione el botón
Future<void> pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Permite cualquier tipo de archivo
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      print('result-archivo-Archivo seleccionado: ${file.path}');
      await sendFileToApi(file); // Envía el archivo a la API
    } else {
      print('result-archivo-No se seleccionó ningún archivo');
    }
  } catch (e) {
    print('result-archivo-Error al seleccionar el archivo: $e');
  }
}

Future<void> sendFileToApi(File file) async {
  // Lógica para enviar el archivo a la API
  print('Enviando archivo a la API: ${file.path}');
}

class FilePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Llama a la función para seleccionar y enviar el archivo
        await pickFile();
      },
      child: Text('Seleccionar Imagen'),
    );
  }
}

//******************* */
//subida de archivo

//******************* */
//selccionador de cantidades

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged; // Función callback

  const QuantitySelector({
    Key? key,
    required this.initialQuantity,
    required this.onQuantityChanged, // Recibimos la función callback
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Cantidad: ', style: TextStyle(fontSize: 14)),
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: quantity > 1
              ? () {
                  setState(() {
                    quantity--;
                  });
                  widget.onQuantityChanged(quantity); // Llamamos la función callback
                }
              : null,
        ),
        Text('$quantity', style: TextStyle(fontSize: 16)),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            setState(() {
              quantity++;
            });
            widget.onQuantityChanged(quantity); // Llamamos la función callback
          },
        ),
      ],
    );
  }
}

//******************* */
//selccionador de cantidades
