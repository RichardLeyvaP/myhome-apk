import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';
import 'package:myhome/domain/modelos/category_model.dart';
import 'package:myhome/ui/pages/rol-admin/Task/selectDays/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geolocator/geolocator.dart';

class SecondTaskPage extends StatefulWidget {
  final PageController pageController;

  const SecondTaskPage({super.key, required this.pageController});

  @override
  _SecondTaskPageState createState() => _SecondTaskPageState();
}

class _SecondTaskPageState extends State<SecondTaskPage> {
  //**esto es para la localizacion */
  String _locationMessage = "Sin Ubicación";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "El servicio de ubicación está desactivado.";
      });
      return;
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Los permisos de ubicación están denegados.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Los permisos de ubicación están permanentemente denegados.";
      });
      return;
    }

    // Obtener la posición actual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _locationMessage = 'Latitud: ${position.latitude}, Longitud: ${position.longitude}';
    });
  }

  //**esto es para la localizacion */
  final _formKey = GlobalKey<FormState>();
  List<int> arrayCategory = [1]; // Inicializamos la cantidad seleccionada
  String selectedFrequency = ''; // Para seleccionar el nivel

  int selectedLevel = 0; // Para seleccionar el nivel
  Color colorBotoom = const Color.fromARGB(255, 61, 189, 93);
  Color colorBotoomSel = const Color.fromARGB(255, 199, 64, 59);

  String getRecurrence(int index) {
    String _recurrence = 'Diaria';
    if (selectedLevel == index) {
      _recurrence = 'Semanal';
    } else if (selectedLevel == index) {
      _recurrence = 'Mensual';
    } else if (selectedLevel == index) {
      _recurrence = 'Anual';
    }
    return _recurrence;
  }

  //**variables del dataTimer */
  DateTime _focusedDay = DateTime.now();
  DateTimeRange? _selectedDateRange;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  static final kFirstDay = DateTime(2020, 1, 1);
  static final kLastDay = DateTime(2030, 12, 31);

  // Selección de horas
  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Aceptar',
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          print('selcct dataHora-$_startTime');
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
          print('selcct dataHora-F$_endTime');
        }
      });
    }
  }

  // Formato completo con fecha y hora, imprime por separado
  String _formatDateTime(DateTime date, TimeOfDay? time) {
    if (time == null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      print('Fecha seleccionada: $formattedDate'); // Imprimir solo la fecha
      return DateFormat('yyyy-MM-dd').format(date);
    } else {
      final DateTime dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

      // Formateamos por separado
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

      // Imprimimos fecha y hora por separado
      print('ffff-Fecha seleccionada: $formattedDate');
      print('ffff-Hora seleccionada: $formattedTime');

      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
  }

  //**variables del dataTimer */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0, // Asegúrate de que no tenga sombras adicionales
          title: const Center(
            child: Column(
              children: [
                Text(
                  'Crear Tarea',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  '(Paso 2 de 2)',
                  style: TextStyle(fontSize: 10, color: Color.fromARGB(150, 0, 0, 0)),
                ),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Altura de la línea
            child: Divider(
              height: 1.0, // Altura de la línea
              thickness: 2.0, // Grosor de la línea
              color: Color.fromARGB(50, 158, 158, 158), // Color de la línea
            ),
          ),
        ),
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0), // Ajusta el valor a tu necesidad
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(MdiIcons.lightbulbQuestionOutline), // Aquí defines el ícono
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        if (state is TaskUpdated) {
                          //  _locationController.text = state.taskElement.description.toString();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Familiares',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            _buildFamilySection(),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Frecuencia',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            _buildRecurrenceSection(),
                            const SizedBox(height: 10),
                            _buildLocationSection(),
                            const SizedBox(height: 10),
                            FilePickerButton(),
                            _buildCalendarSection(context),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text("Regresar"),
                    ),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text("Crear Tarea"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFamilySection() {
    return BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
      builder: (context, state) {
        if (state is CategoriesStatusPrioritySuccess) {
          return SizedBox(
            height: 80, // Ajusta esta altura según tus necesidades
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.taskperson.length,
              itemBuilder: (context, index) {
                final taskperson = state.taskperson[index];
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    context.read<CategoriesStatePrioritiesBloc>().add(PersonEvent(taskperson.id));
                  },
                  child: cardSimpleSelectionFamily(state, taskperson),
                );
              },
            ),
          );
        } else if (state is CategoriesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }

  _buildLocationSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.mapMarker),
            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: null,
          //  onPressed: _getCurrentLocation,//probar en un telefono físico, en el emulador no funcionó
          child: Text('Obtener Ubicación'),
        ),
      ],
    );
  }

  _buildCalendarSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                // titleTextFormatter: (date, locale) => '', // Oculta el título
                formatButtonVisible: false, // Oculta el botón de formato
                // titleCentered: true,
                // leftChevronVisible: false, // Oculta el botón de navegación izquierda
                // rightChevronVisible: false, // Oculta el botón de navegación derecha
              ),
              locale: 'es_ES',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: RangeSelectionMode.toggledOn, // Activar selección de rango
              selectedDayPredicate: (day) {
                FocusScope.of(context).unfocus();
                return _selectedDateRange != null &&
                    (isSameDay(_selectedDateRange!.start, day) || isSameDay(_selectedDateRange!.end, day));
              },
              rangeStartDay: _selectedDateRange?.start,
              rangeEndDay: _selectedDateRange?.end,
              onRangeSelected: (start, end, focusedDay) async {
                // Resetear horas cuando cambia el rango
                setState(() {
                  _selectedDateRange = DateTimeRange(start: start!, end: end ?? start);
                  _focusedDay = focusedDay;
                  _startTime = null;
                  _endTime = null;
                });
                print('selcct dataHora-zzzzz');
                print('selcct dataHora-zzzzz-start:$start');
                print('selcct dataHora-zzzzz-end:$end');

                // Selecciona la hora de inicio
                if (start != null) {
                  await _selectTime(context, true); // Seleccionar hora para la fecha de fin
                }
                // Selecciona la hora de fin solo si hay una fecha final seleccionada
                if (end != null) {
                  await _selectTime(context, false); // Seleccionar hora para la fecha de fin
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            if (_selectedDateRange != null && _startTime != null && _endTime != null) ...[
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  border: Border.all(
                    color: selectedLevel == 2
                        ? colorBotoomSel.withOpacity(0.8)
                        : colorBotoom.withOpacity(0.4), // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: selectedLevel == 2
                          ? colorBotoomSel.withOpacity(0.4)
                          : colorBotoom.withOpacity(0.4), // Sombra roja
                      spreadRadius: 0, // Asegura que la sombra esté en el borde
                      blurRadius: 10, // Difumina la sombra
                      offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
                    ),
                  ],
                ),
                child: Center(child: Text('Inicial:${_formatDateTime(_selectedDateRange!.start, _startTime)}')),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  border: Border.all(
                    color: selectedLevel == 2
                        ? colorBotoomSel.withOpacity(0.8)
                        : colorBotoom.withOpacity(0.4), // Color del borde
                    width: 2.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: selectedLevel == 2
                          ? colorBotoomSel.withOpacity(0.4)
                          : colorBotoom.withOpacity(0.4), // Sombra roja
                      spreadRadius: 0, // Asegura que la sombra esté en el borde
                      blurRadius: 10, // Difumina la sombra
                      offset: Offset(0, 0), // Posiciona la sombra en las 4 partes
                    ),
                  ],
                ),
                child: Center(child: Text('Final:${_formatDateTime(_selectedDateRange!.end, _endTime)}')),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _buildRecurrenceSection() {
    return BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
      builder: (context, state) {
        /*
                              if (state is CategoriesLoading) {
                                return Center(child: CircularProgressIndicator());
                              } else 
                              */
        if (state is CategoriesStatusPrioritySuccess) {
          return SizedBox(
            height: 70, // Ajusta esta altura según tus necesidades
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.taskrecurrences.length,
              itemBuilder: (context, index) {
                String status = state.taskrecurrences[index];
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    // Actualizar el estado seleccionado
                    selectedFrequency = status;
                    context.read<CategoriesStatePrioritiesBloc>().add(FrequencyEvent(selectedFrequency));
                  },
                  child: cardSimpleSelectionFrecuncy(state, status),
                );
              },
            ),
          );
        } else if (state is CategoriesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Cierra el teclado si está abierto
      FocusScope.of(context).unfocus();
      // Enviar el evento al BLoC

      //todo ahora esta fijo
      //mandar la prioridad
      context.read<TasksBloc>().add(
            TaskRecurrenceUpdated(getRecurrence(selectedLevel)),
          );

      eventDate(); //ACTUALIZA LA FECHA , SI NO LA ESCOJE LE PONE LA ACTUAL

      // Pasar la fecha al evento
      final taskState = context.read<TasksBloc>().state;

// Verificamos si el estado es TaskUpdated
      print('Selected taskElement1: ${taskState}');
      final currentState = context.read<CategoriesStatePrioritiesBloc>().state;

      if (currentState is CategoriesStatusPrioritySuccess) {
        print('Selected taskElement2: ${currentState}');
        // Crear el objeto TaskElement a partir del estado actual
        final taskElement = TaskElement(); //aqui creo el objeto con tds los datos
        context.read<TasksBloc>().add(
              TaskSubmitted(taskElement),
            );
      }

      // Navegar a la siguiente página

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Se está creando la tarea...'),

          duration: Duration(seconds: 2), // Duración del SnackBar
          action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () {
              // Acción a realizar si se presiona el botón
            },
          ),
        ),
      );
//llamar que actualice las tareas al dia seleccionado
//  String date = '2024-09-09'; // La fecha puede ser dinámica
      context.read<TasksBloc>().add(TasksRequested('2024-10-15')); // Pasar la fecha al evento
      Future.delayed(const Duration(seconds: 2), () {
        GoRouter.of(context).go(
          '/HomePrincipal',
          extra: {
            'name': '',
            'email': '',
            'avatarUrl': '',
          },
        );
      });
      // Navegar a la siguiente página
      /*  widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );*/
    }
  }

  Widget cardSimpleSelectionFamily(CategoriesStatusPrioritySuccess state, Taskperson status) {
    bool isSelected = state.selectedPersonIds.contains(1);

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(status.imagePerson),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    status.namePerson,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.red : Colors.black,
                    ),
                  ),
                  Text(
                    status.nameRole,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardSimpleSelectionFrecuncy(CategoriesStatusPrioritySuccess state, String status) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
      child: Container(
        // height: 20,
        width: 120,
        // margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: state.frequencytask == status ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: state.frequencytask == status ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: state.frequencytask == status ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitIncomple() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Escoja la fecha y hora por favor'),

        duration: Duration(seconds: 2), // Duración del SnackBar
        action: SnackBarAction(
          label: 'Aceptar',
          onPressed: () {
            // Acción a realizar si se presiona el botón
          },
        ),
      ),
    );
  }

//*****LLAMADAS A EVENTOS BLOC***/
  void eventDate() {
    //mandar la fecha
    if (_selectedDateRange == null) //si el rango es null que coja la fecha actual
    {
      // Si _selectedDateRange es null, asignamos la fecha actual como inicio y fin.
      final DateTime startDate = _selectedDateRange?.start ?? DateTime.now();
      final DateTime endDate = _selectedDateRange?.end ?? DateTime.now();

      // Si _startTime es null, asignamos las 7:00 AM como hora predeterminada.
      final TimeOfDay startTime = _startTime ?? TimeOfDay(hour: 7, minute: 0);

// Si _endTime es null, asignamos las 6:00 PM como hora predeterminada.
      final TimeOfDay endTime = _endTime ?? TimeOfDay(hour: 18, minute: 0);

      context.read<TasksBloc>().add(
            TaskDateTimeUpdated(
              _formatDateTime(startDate, startTime),
              _formatDateTime(endDate, endTime),
            ),
          );
    } else {
      context.read<TasksBloc>().add(
            TaskDateTimeUpdated(_formatDateTime(_selectedDateRange!.start, _startTime),
                _formatDateTime(_selectedDateRange!.end, _endTime)),
          );
    }
  }
}
