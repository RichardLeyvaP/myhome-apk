import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_categories_status_priority.freezed.dart';
part 'task_categories_status_priority.g.dart';

//  factory Login.fromJson(Map<String, Object?> json) => _$LoginFromJson(json);
@freezed
class TaskCategoriesStatusPriority with _$TaskCategoriesStatusPriority {
  const factory TaskCategoriesStatusPriority({
    required List<Category> categories,
    required List<Status> status,
    required List<Priority> priorities,
  }) = _TaskCategoriesStatusPriority;
  factory TaskCategoriesStatusPriority.fromJson(Map<String, Object?> json) =>
      _$TaskCategoriesStatusPriorityFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String nameCategory,
    required String descriptionCategory,
    required String colorCategory,
    required String iconCategory,
    required int? parentId,
    required List<Category> children,
  }) = _Category;
  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);
}

@freezed
class Priority with _$Priority {
  const factory Priority({
    required int id,
    required String namePriority,
    required String descriptionPriority,
    required String colorPriority,
    required int level,
  }) = _Priority;
  factory Priority.fromJson(Map<String, Object?> json) => _$PriorityFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
    required int id,
    required String nameStatus,
    required String descriptionStatus,
    required String colorStatus,
    required dynamic iconStatus,
  }) = _Status;
  factory Status.fromJson(Map<String, Object?> json) => _$StatusFromJson(json);
}
