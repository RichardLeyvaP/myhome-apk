import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/domain/blocs/task_cat_state_prior.dart/task_cat_state_prior_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_bloc.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';
import 'package:myhome/domain/modelos/category_model.dart';
import 'package:myhome/ui/Components/category_widget.dart';
import 'package:myhome/ui/Components/priority_widget.dart';
import 'package:myhome/ui/Components/state_widget.dart';

class StartTaskPage extends StatefulWidget {
  final PageController pageController;

  StartTaskPage({required this.pageController});

  @override
  _StartTaskPageState createState() => _StartTaskPageState();
}

class _StartTaskPageState extends State<StartTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<int> arrayCategory = [1];

  int selectedPriority = 0;
  int selectedStatus = 0;
  final Color colorBotoom = const Color.fromARGB(255, 61, 189, 93);
  final Color colorBotoomSel = const Color.fromARGB(255, 199, 64, 59);

  // Variable para manejar las prioridades seleccionadas
  List<Priority> selectedPriorities = [];

  // Método que será llamado cuando se seleccionen o deseleccionen prioridades
  void _onSelectionChanged(List<Priority> selectedPrioritiesList) {
    selectedPriorities = selectedPrioritiesList;

    // Aquí manejas los estados seleccionados
    // print('Estados seleccionados: ${selectedStatuses.map((e) => e.id)}');
    print('Estados seleccionados: ${selectedPrioritiesList.map((e) => e.id).join(', ')}');
    selectedPriority = selectedPrioritiesList.isNotEmpty ? selectedPrioritiesList.first.id : 0;
    print('Estados seleccionados: $selectedStatus');

    context
        .read<CategoriesStatePrioritiesBloc>()
        .add(SelectedPriorityIdEvent(selectedPriority)); //aqui para que mantenga la ultima que seleccionó
    TaskElement newTaskElement = TaskElement(
      priorityId: selectedPriorities.first.id, // Ajusta el ID de estado según sea necesario
    );
    print('Estados seleccionados-elementos de la primera pagina:${newTaskElement.priorityId}');
    context
        .read<TasksBloc>()
        .add(TasksNewUpdated(newTaskElement)); //aqui va agregando a TaskElement para luego crear la tarea
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Column(
              children: [
                Text('Crear Tarea', style: TextStyle(fontSize: 18, color: Colors.black)),
                Text('(Paso 1 de 2)', style: TextStyle(fontSize: 10, color: Color.fromARGB(150, 0, 0, 0))),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.close, color: Colors.black),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(height: 1.0, thickness: 2.0, color: Color.fromARGB(50, 158, 158, 158)),
          ),
        ),
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(MdiIcons.lightbulbQuestionOutline),
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
                        if (state is TaskTitleUpdated) {
                          //  WidgetsBinding.instance.addPostFrameCallback((_) {
                          _titleController.text = state.taskElement.title.toString();
                          _descriptionController.text = state.taskElement.description.toString();
                          // });
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10),
                            _buildTextFormField(
                              controller: _titleController,
                              labelText: 'Título',
                              maxLength: 30,
                              validator: (value) => (value == null || value.isEmpty) ? 'El título es requerido' : null,
                            ),
                            const SizedBox(height: 10),
                            _buildCategorySection(),
                            const SizedBox(height: 10),
                            _buildPrioritySection(),
                            const SizedBox(height: 10),
                            _buildStatusSection(),
                            const SizedBox(height: 20),
                            _buildTextFormField(
                              controller: _descriptionController,
                              labelText: 'Descripción',
                              maxLines: 2,
                              onFieldSubmitted: (_) => _onSubmit(),
                            ),
                            SizedBox(height: 10),
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
                      onPressed: () => GoRouter.of(context).go('/HomePrincipal'),
                      child: Text("Regresar"),
                    ),
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text("Siguiente"),
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

  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    int? maxLength,
    int? maxLines,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  Widget _buildCategorySection() {
    return BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoriesStatusPrioritySuccess) {
          return CategoryWidget(
            eventDetails: false,
            fitTextContainer: false,
            categories: state.categories,
            titleWidget: 'Categoría',
            selectedCategoryId: state.selectedCategoryId,
            selectMultiple: false,
            onSelectionChanged: (selectedCategories) {
              setState(() {
                FocusScope.of(context).unfocus();
                arrayCategory = selectedCategories.map((category) => category.id).toList();
                if (arrayCategory.isNotEmpty) {
                  context.read<CategoriesStatePrioritiesBloc>().add(CategoryTaskSelectedEvent(arrayCategory.first));
                  TaskElement newTaskElement = TaskElement(
                    categoryId: arrayCategory.first, // Ajusta el ID de estado según sea necesario
                  );
                  print('Estados seleccionados-elementos de la primera pagina:${newTaskElement.statusId}');
                  context
                      .read<TasksBloc>()
                      .add(TasksNewUpdated(newTaskElement)); //aqui va agregando a TaskElement para luego crear la tarea
                }
              });
            },
          );
        } else if (state is CategoriesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }

  Widget _buildPrioritySection() {
    return BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
      builder: (context, state) {
        if (state is CategoriesStatusPrioritySuccess) {
          int? _selectPrioritytask = state.selectedPriorityId;
          return PriorityWidget(
            priorities: state.priority,
            titleWidget: 'Prioridad',
            selectMultiple: false, // Cambia a false si solo quieres una selección
            selectedPriorityId: _selectPrioritytask,
            onSelectionChanged: _onSelectionChanged,
          );
        } else if (state is CategoriesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }

  Widget _buildStatusSection() {
    return BlocBuilder<CategoriesStatePrioritiesBloc, CategoriesStatePrioritiesState>(
      builder: (context, state) {
        if (state is CategoriesStatusPrioritySuccess) {
          int? _selectStatetask = state.selectStatetask;
          return StatusWidget(
            status: state.status,
            fitTextContainer: false,
            eventDetails: true,
            titleWidget: 'Estado',
            selectMultiple: false, // Permite seleccionar solo un estado
            selectedStatusId: _selectStatetask, // Estado preseleccionado
            onSelectionChanged: (List<Status> selectedStatuses) {
              // Aquí manejas los estados seleccionados
              print('Estados seleccionados: ${selectedStatuses.map((e) => e.id).join(', ')}');
              selectedStatus = selectedStatuses.isNotEmpty ? selectedStatuses.first.id : 0;
              print('Estados seleccionados: $selectedStatus');

              context
                  .read<CategoriesStatePrioritiesBloc>()
                  .add(SelectStateEvent(selectedStatus)); //aqui para que mantenga la ultima que seleccionó
              TaskElement newTaskElement = TaskElement(
                statusId: selectedStatus, // Ajusta el ID de estado según sea necesario
              );
              print('Estados seleccionados-elementos de la primera pagina:${newTaskElement.statusId}');
              context
                  .read<TasksBloc>()
                  .add(TasksNewUpdated(newTaskElement)); //aqui va agregando a TaskElement para luego crear la tarea
            },
          );
        } else if (state is CategoriesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Container();
      },
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Crea un nuevo TaskElement

      TaskElement newTaskElement = TaskElement(
        title: _titleController.text, // Agrega el título deseado
        description: _descriptionController.text, // Agrega la descripción deseada
      );
      context
          .read<TasksBloc>()
          .add(TasksNewUpdated(newTaskElement)); //aqui va agregando a TaskElement para luego crear la tarea

      context.read<TasksBloc>().add(TaskTitleDescriptionUpdated(
          _titleController.text,
          _descriptionController
              .text)); //aqui para guardar independientemente el titulo y la descripcion para que si da para atras cargue

      // final currentState = context.read<CategoriesStatePrioritiesBloc>().state;

      // if (currentState is CategoriesStatusPrioritySuccess) {
      //   // Accediendo a los datos que necesitas
      //   final selectedPriorityId = currentState.selectedPriorityId;
      //   final selectedCategoryId = currentState.selectedCategoryId;
      //   final selectedStateTask = currentState.selectStatetask;
      //   final selectedPersonIds = currentState.selectedPersonIds;

      //   // Utiliza los datos según tus necesidades
      //   print('Selected Priority ID: $selectedPriorityId');
      //   print('Selected Category ID: $selectedCategoryId');
      //   print('Selected State Task: $selectedStateTask');
      //   print('Selected Person IDs: $selectedPersonIds');}

      // Navegar a la siguiente página
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  cardSimpleSelectionStatus(CategoriesStatusPrioritySuccess state, Status status) {
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
            color: state.selectStatetask == status.id ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  state.selectStatetask == status.id ? colorBotoomSel.withOpacity(0.4) : colorBotoom.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              status.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: state.selectStatetask == status.id ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  cardSimpleSelection(CategoriesStatusPrioritySuccess state, Priority status) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10.0, bottom: 10),
      child: Container(
        // height: 20,
        width: 80,
        // margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                state.selectedPriorityId == status.id ? colorBotoomSel.withOpacity(0.8) : colorBotoom.withOpacity(0.4),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: state.selectedPriorityId == status.id
                  ? colorBotoomSel.withOpacity(0.4)
                  : colorBotoom.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              status.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: state.selectedPriorityId == status.id ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
