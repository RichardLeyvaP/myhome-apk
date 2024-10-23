import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';
import 'package:myhome/ui/pages/rol-admin/Task/selectDays/utils.dart';
import 'package:myhome/ui/pages/pageMenu/task/widget/cardTasksW.dart';
import 'package:myhome/ui/util/util_class.dart';
import 'package:myhome/ui/util/utils_class_apk.dart';
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

/*
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
*/
  @override
  void initState() {
    super.initState();
    // Inicializamos el primer día con algún contenido
    _selectedDay = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(_selectedDay!);
    context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento

    //_updateEvents();
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
              // print('calendario seleccion:${DateFormat('yyyy-MM-dd').format(selectedDay)}');
              setState(() {
                String date = DateFormat('yyyy-MM-dd').format(selectedDay);
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                //  String date = '2024-09-09'; // La fecha puede ser dinámica
                context.read<TasksBloc>().add(TasksRequested(date)); // Pasar la fecha al evento
                //  _updateEvents();
              });
            }
          },
          headerStyle: const HeaderStyle(
            //estilo de texto de Septiembre del 2024
            formatButtonVisible: true, // Ocultar el botón de formato si no lo necesitas

            formatButtonTextStyle: TextStyle(
              fontSize: 11.0,
              color: Colors.black, // Cambiar el color del texto
              fontWeight: FontWeight.bold,
            ),

            titleTextStyle: TextStyle(
              fontSize: 12.0, // Cambia el tamaño de la letra aquí
              fontWeight: FontWeight.bold,
              color: Colors.black, // Cambia el color del texto
            ),
            titleCentered: false,
            headerMargin: EdgeInsets.only(bottom: 0), // Ajusta el margen inferior
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 12.0), // Tamaño del texto de los días de la semana
            weekendStyle: TextStyle(fontSize: 12.0), // Tamaño del texto del fin de semana
          ),
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
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: StyleGlobalApk.colorIndicator.withOpacity(0.5), // Color para el día de hoy
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: StyleGlobalApk.colorIndicator, // Color para el día de hoy
              shape: BoxShape.circle,
            ),
          ),
        ),

        //todo el que estaba estatico
        Expanded(
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                // Mostrar un indicador de carga mientras se obtienen las tareas
                return Center(
                    child: CircularProgressIndicator(
                  color: StyleGlobalApk.getColorPrimary(),
                ));
              } else if (state is TasksFailure) {
                // Mostrar un mensaje de error en caso de falla
                return Center(child: Text(TranslationManager.translate('serverError'))); //serverError
                //todoMetodoRutaStatusCode este error para la db y guardarlo
                // return Center(child: Text('Ha ocurrido un Error: ${state.error}'));
              } else if (state is TasksEmpty) {
                // Mostrar mensaje si no hay tareas para ese día
                return Column(
                  children: [
                    const SizedBox(height: 180), //aqui el mensaje cuando esta vacio
                    Center(child: Text(TranslationManager.translate('noResults'))),
                    //Center(child: Text(state.message)),
                  ],
                );
              } else if (state is TasksSuccess) {
                List<TaskElement> tasks = state.tasks.tasks; // Asegúrate que sea una lista de tareas

                // Construir la lista de `CardTasks` dependiendo de la longitud de las tareas
                return SingleChildScrollView(
                  child: Column(
                    children: tasks.map((task) {
                      print('personas por tarea:${task.people![0].name}');
                      return CardTasks(
                        title: task.title!, // Aquí usas el título de la tarea
                        namePriority: task.namePriority!,
                        iconPriority:
                            getIconFromString(task.namePriority!), //dado el nombre de la prioridad devuelve el icon
                        colorPriority: getColorConvert(task.colorPriority!),
                        icon: getIconFromString(task.iconCategory!), // Puedes cambiar el ícono
                        // icon: MdiIcons.cakeVariantOutline, // Puedes cambiar el ícono
                        date: formatDate(task.startDate!), // Aquí usas la fecha de inicio de la tarea
                        details: task.description!, // Descripción de la tarea
                        location: task.geoLocation!,
                        schedule: '${extractTime(task.startDate!)} - ${extractTime(task.endDate!)}', // Horario
                        iconSize: 12.0,
                        iconColor: getColorConvert(task.colorCategory!),
                        //iconColor: Color(int.parse(task.colorPriority, radix: 16)),
                        padding: 8.0,
                        people: task.people!,
                        // radius: 30,
                      );
                    }).toList(),
                  ),
                );
              } else {
                // Retorna un widget vacío en caso de que no coincida ningún estado
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
