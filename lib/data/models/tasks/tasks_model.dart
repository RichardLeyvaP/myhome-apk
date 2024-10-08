import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_model.freezed.dart';
part 'tasks_model.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required List<TaskElement> tasks,
  }) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}

@freezed
class TaskElement with _$TaskElement {
  const factory TaskElement({
    required int id,
    required String title,
    required String description,
    required String startDate,
    required String endDate,
    required int priorityId,
    required int statusId,
    required int categoryId,
    required String recurrence,
    required String colorPriority,
    required String colorCategory,
    required String iconCategory,
    required String namePriority,
    required int estimatedTime,
    required String? comments,
    required String? attachments,
    required String geoLocation,
    required int? parentId, // Puede ser nulo si es la tarea principal
    required List<TaskElement> children, // Aquí es donde ocurre la recursividad
  }) = _TaskElement;

  factory TaskElement.fromJson(Map<String, Object?> json) => _$TaskElementFromJson(json);
}
