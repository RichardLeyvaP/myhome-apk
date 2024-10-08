import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

// Estado inicial
class TasksInitial extends TasksState {}

// Estado de carga mientras se recuperan las tareas
class TasksLoading extends TasksState {}

// Estado para cuando no hay tareas disponibles
class TasksEmpty extends TasksState {
  final String message;

  const TasksEmpty(this.message);

  @override
  List<Object> get props => [message];
}

// Estado de éxito cuando se recuperan las tareas
class TasksSuccess extends TasksState {
  final Task tasks;

  const TasksSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskDataUpdated extends TasksState {
  final String title;
  final String description;

  const TaskDataUpdated({
    required this.title,
    required this.description,
  });
  @override
  List<Object> get props => [title, description];
}

// Estado de error al cargar tareas
class TasksFailure extends TasksState {
  final String error;

  const TasksFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Estado cuando se actualizan los datos de la tarea (como título, descripción, etc.)
class TaskUpdated extends TasksState {
  final TaskElement taskElement;

  const TaskUpdated(this.taskElement);

  @override
  List<Object> get props => [taskElement];
}

// Estado mientras se envía la tarea a la API
class TaskSubmitting extends TasksState {}

// Estado de éxito cuando se envía la tarea a la API
class TaskSubmittedSuccess extends TasksState {}

// Estado de error al enviar la tarea a la API
class TaskSubmittedFailure extends TasksState {
  final String error;

  const TaskSubmittedFailure({required this.error});

  @override
  List<Object> get props => [error];
}
