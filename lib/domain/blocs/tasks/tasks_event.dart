import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

// Evento para solicitar las tareas por fecha
class TasksRequested extends TasksEvent {
  final String date;

  const TasksRequested(this.date);

  @override
  List<Object> get props => [date];
}

// Evento para actualizar el título y la descripción de una tarea
class TaskTitleDescriptionUpdated extends TasksEvent {
  final String title;
  final String description;

  const TaskTitleDescriptionUpdated(this.title, this.description);

  @override
  List<Object> get props => [title, description];
}

// Evento para actualizar la prioridad de la tarea
class TaskPriorityUpdated extends TasksEvent {
  final int priorityId;

  const TaskPriorityUpdated(this.priorityId);

  @override
  List<Object> get props => [priorityId];
}

// Evento para actualizar la status de la tarea
class TaskStatusUpdated extends TasksEvent {
  final int statusId;

  const TaskStatusUpdated(this.statusId);

  @override
  List<Object> get props => [statusId];
}

// Evento para actualizar la categoria de la tarea
class TaskCategoryUpdated extends TasksEvent {
  final int categoryId;

  const TaskCategoryUpdated(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

// Evento para actualizar la categoria de la tarea
class TaskRecurrenceUpdated extends TasksEvent {
  final String recurrence;

  const TaskRecurrenceUpdated(this.recurrence);

  @override
  List<Object> get props => [recurrence];
}

// Evento para actualizar la data inicial-final de la tarea
class TaskDateTimeUpdated extends TasksEvent {
  final String startDate;
  final String endDate;

  const TaskDateTimeUpdated(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

// Evento para actualizar los familiares (children) de la tarea
class TaskFamilyUpdated extends TasksEvent {
  final List<TaskElement> familyMembers;

  const TaskFamilyUpdated(this.familyMembers);

  @override
  List<Object> get props => [familyMembers];
}

// Evento para enviar la tarea final
class TasksNewUpdated extends TasksEvent {
  //este sera el modificar de todos los componentes de la pantalla
  final TaskElement taskElement;

  const TasksNewUpdated(this.taskElement);

  @override
  List<Object> get props => [taskElement];
}

// Evento para enviar la tarea final
class TaskSubmitted extends TasksEvent {
  final TaskElement taskElement;

  const TaskSubmitted(this.taskElement);

  @override
  List<Object> get props => [taskElement];
}
