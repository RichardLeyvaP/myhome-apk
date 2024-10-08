import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';
import 'package:myhome/data/repository/tasks_repository.dart';
import 'package:myhome/domain/blocs/tasks/tasks_event.dart';
import 'package:myhome/domain/blocs/tasks/tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepository tasksRepository;

  // Mantiene el estado de la tarea actual
  TaskElement _taskElement = const TaskElement(
    id: 0,
    title: '',
    description: '',
    startDate: '',
    endDate: '',
    priorityId: 0,
    namePriority: '',
    statusId: 0,
    categoryId: 0,
    recurrence: '',
    estimatedTime: 0,
    comments: '',
    attachments: '',
    geoLocation: '',
    colorPriority: '',
    iconCategory: '',
    colorCategory: '',
    parentId: null,
    children: [],
  );

  TasksBloc({required this.tasksRepository}) : super(TasksInitial()) {
    on<TasksRequested>(_onTaskRequested);
    on<TaskTitleDescriptionUpdated>(_onTaskTitleDescriptionUpdated);
    on<TaskPriorityUpdated>(_onTaskPriorityUpdated);
    on<TaskFamilyUpdated>(_onTaskFamilyUpdated);
    on<TaskStatusUpdated>(_onTaskStatusUpdated);
    on<TaskCategoryUpdated>(_onTaskCategoryUpdated);
    on<TaskDateTimeUpdated>(_onTaskDateTimeUpdated);
    on<TaskRecurrenceUpdated>(_onTaskRecurrenceUpdated);
    on<TaskSubmitted>(_onTaskSubmitted);
  }

  // Manejar solicitud de tareas
  Future<void> _onTaskRequested(TasksRequested event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final result = await tasksRepository.getTasks(event.date); // Usar la fecha del evento

      if (result is String) {
        emit(TasksEmpty(result));
      } else if (result is Task) {
        emit(TasksSuccess(result));
      }
    } catch (error) {
      emit(TasksFailure(error.toString()));
    }
  }

  // Manejar actualización de título y descripción
  void _onTaskTitleDescriptionUpdated(TaskTitleDescriptionUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(
      title: event.title,
      description: event.description,
    );
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de prioridad
  void _onTaskPriorityUpdated(TaskPriorityUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(priorityId: event.priorityId);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de familiares
  void _onTaskFamilyUpdated(TaskFamilyUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(children: event.familyMembers);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de Status
  void _onTaskStatusUpdated(TaskStatusUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(statusId: event.statusId);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de Status
  void _onTaskCategoryUpdated(TaskCategoryUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(categoryId: event.categoryId);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de Status
  void _onTaskDateTimeUpdated(TaskDateTimeUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(startDate: event.startDate, endDate: event.endDate);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar actualización de Status
  void _onTaskRecurrenceUpdated(TaskRecurrenceUpdated event, Emitter<TasksState> emit) {
    _taskElement = _taskElement.copyWith(recurrence: event.recurrence);
    emit(TaskUpdated(_taskElement));
  }

  // Manejar envío de la tarea a la API
  Future<void> _onTaskSubmitted(TaskSubmitted event, Emitter<TasksState> emit) async {
    emit(TaskSubmitting());
    try {
      await tasksRepository.addTasks(_taskElement); // Enviar la tarea completa a la API
      emit(TaskSubmittedSuccess());
    } catch (error) {
      emit(TaskSubmittedFailure(error: error.toString()));
    }
  }
}
