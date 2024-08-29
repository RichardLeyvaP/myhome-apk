import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/ui/pages/initial/Task/selectDays/utils.dart';
import 'package:myhome/ui/pages/pageMenu/widget/cardTasksW.dart';
import 'package:table_calendar/table_calendar.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  int selectedDay = DateTime.now().day;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Widget> _events = [];

  void _updateEvents() {
    // Aquí puedes personalizar qué eventos se muestran dependiendo del día
    Future.delayed(Duration(seconds: 3));
    if (isSameDay(_selectedDay, DateTime(2024, 8, 29))) {
      _events = [
        CardTasks(
          title: 'Compras en el Supermecado',
          icon: MdiIcons.cartOutline,
          date: '2024-08-29',
          details: 'sd',
          schedule: '10:00 - 12:00',
          iconSize: 12.0,
          iconColor: Colors.blue,
        ),
        CardTasks(
          title: 'Reunión de trabajo',
          icon: MdiIcons.briefcaseOutline,
          date: '2024-08-29',
          details: 'Duración: 2h',
          schedule: '10:40 - 11:25',
          iconSize: 12.0,
          iconColor: Colors.purple,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Cita con dentista',
          icon: MdiIcons.toothOutline,
          date: '2024-08-29',
          details: 'Duración: 1h',
          schedule: '14:00 - 16:00',
          iconSize: 12.0,
          iconColor: Colors.teal,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Clases de yoga',
          icon: MdiIcons.yoga,
          date: '2024-08-29',
          details: 'Duración: 1h',
          schedule: '08:00 - 09:00',
          iconSize: 12.0,
          iconColor: Colors.orange,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Viaje al aeropuerto',
          icon: MdiIcons.airplaneTakeoff,
          date: '2024-08-29',
          details: 'Duración: 3h',
          schedule: '16:00 - 16:40',
          iconSize: 12.0,
          iconColor: Colors.blue,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Cena con amigos',
          icon: MdiIcons.silverwareForkKnife,
          date: '2024-08-29',
          details: 'Duración: 2h',
          schedule: '10:40 - 12:10',
          iconSize: 12.0,
          iconColor: Colors.green,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Entrenamiento en el gimnasio',
          icon: MdiIcons.dumbbell,
          date: '2024-08-29',
          details: 'Duración: 1.5h',
          schedule: '20:00 - 21:00',
          iconSize: 12.0,
          iconColor: Colors.redAccent,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Estudio de matemáticas',
          icon: MdiIcons.calculator,
          date: '2024-08-29',
          details: 'Duración: 2h',
          schedule: '06:00 - 10:00',
          iconSize: 12.0,
          iconColor: Colors.indigo,
          padding: 8.0,
        ),
      ];
    } else if (isSameDay(_selectedDay, DateTime(2024, 8, 30))) {
      _events = [
        CardTasks(
          title: 'Videollamada familiar',
          icon: MdiIcons.videoOutline,
          date: '2024-08-31',
          details: 'Duración: 1h',
          schedule: '18:00 - 18:30',
          iconSize: 12.0,
          iconColor: Colors.cyan,
          padding: 8.0,
        ),
      ];
    } else if (isSameDay(_selectedDay, DateTime(2024, 8, 28))) {
      _events = [
        CardTasks(
          title: 'Cumpleaños de Clara',
          icon: MdiIcons.cakeVariantOutline,
          date: '2024-08-28',
          details: 'sd',
          schedule: '15:00 - 17:00',
          iconSize: 12.0,
          iconColor: const Color.fromARGB(255, 61, 189, 93),
          padding: 8.0,
        ),
      ];
    } else if (isSameDay(_selectedDay, DateTime(2024, 8, 31))) {
      _events = [
        CardTasks(
          title: 'Partido de fútbol',
          icon: MdiIcons.soccer,
          date: '2024-08-31',
          details: 'Duración: 1.5h',
          schedule: '10:00 - 12:00',
          iconSize: 12.0,
          iconColor: Colors.amber,
          padding: 8.0,
        ),
        CardTasks(
          title: 'Visita al museo',
          icon: MdiIcons.artstation,
          date: '2024-08-31',
          details: 'Duración: 2h',
          schedule: '14:00 - 13:00',
          iconSize: 12.0,
          iconColor: Colors.brown,
          padding: 8.0,
        ),
      ];
    } else {
      _events = [
        const Column(
          children: [
            SizedBox(
              height: 180,
            ),
            Center(child: Text('No hay tareas para este día')),
          ],
        ),
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos el primer día con algún contenido
    _selectedDay = DateTime.now();
    _updateEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // El calendario permanece fijo en la parte superior
        TableCalendar(
          locale: 'es_ES',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              print('calendario seleccion:${DateFormat('yyyy-MM-dd').format(selectedDay)}');
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _updateEvents();
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        // El contenido debajo del calendario es desplazable
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: _events, // Lista de eventos
            ),
          ),
        ),
      ],
    );
  }
}
