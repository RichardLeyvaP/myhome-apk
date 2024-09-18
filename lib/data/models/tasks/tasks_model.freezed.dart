// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  List<TaskElement> get tasks => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call({List<TaskElement> tasks});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskElement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TaskElement> tasks});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
  }) {
    return _then(_$TaskImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl({required final List<TaskElement> tasks}) : _tasks = tasks;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  final List<TaskElement> _tasks;
  @override
  List<TaskElement> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'Task(tasks: $tasks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tasks));

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task({required final List<TaskElement> tasks}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  List<TaskElement> get tasks;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskElement _$TaskElementFromJson(Map<String, dynamic> json) {
  return _TaskElement.fromJson(json);
}

/// @nodoc
mixin _$TaskElement {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  int get priorityId => throw _privateConstructorUsedError;
  int get statusId => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get recurrence => throw _privateConstructorUsedError;
  int get estimatedTime => throw _privateConstructorUsedError;
  String? get comments => throw _privateConstructorUsedError;
  String? get attachments => throw _privateConstructorUsedError;
  String get geoLocation => throw _privateConstructorUsedError;
  int? get parentId =>
      throw _privateConstructorUsedError; // Puede ser nulo si es la tarea principal
  List<TaskElement> get children => throw _privateConstructorUsedError;

  /// Serializes this TaskElement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskElementCopyWith<TaskElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskElementCopyWith<$Res> {
  factory $TaskElementCopyWith(
          TaskElement value, $Res Function(TaskElement) then) =
      _$TaskElementCopyWithImpl<$Res, TaskElement>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String startDate,
      String endDate,
      int priorityId,
      int statusId,
      int categoryId,
      String recurrence,
      int estimatedTime,
      String? comments,
      String? attachments,
      String geoLocation,
      int? parentId,
      List<TaskElement> children});
}

/// @nodoc
class _$TaskElementCopyWithImpl<$Res, $Val extends TaskElement>
    implements $TaskElementCopyWith<$Res> {
  _$TaskElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? priorityId = null,
    Object? statusId = null,
    Object? categoryId = null,
    Object? recurrence = null,
    Object? estimatedTime = null,
    Object? comments = freezed,
    Object? attachments = freezed,
    Object? geoLocation = null,
    Object? parentId = freezed,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      priorityId: null == priorityId
          ? _value.priorityId
          : priorityId // ignore: cast_nullable_to_non_nullable
              as int,
      statusId: null == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as String?,
      geoLocation: null == geoLocation
          ? _value.geoLocation
          : geoLocation // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TaskElement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskElementImplCopyWith<$Res>
    implements $TaskElementCopyWith<$Res> {
  factory _$$TaskElementImplCopyWith(
          _$TaskElementImpl value, $Res Function(_$TaskElementImpl) then) =
      __$$TaskElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String startDate,
      String endDate,
      int priorityId,
      int statusId,
      int categoryId,
      String recurrence,
      int estimatedTime,
      String? comments,
      String? attachments,
      String geoLocation,
      int? parentId,
      List<TaskElement> children});
}

/// @nodoc
class __$$TaskElementImplCopyWithImpl<$Res>
    extends _$TaskElementCopyWithImpl<$Res, _$TaskElementImpl>
    implements _$$TaskElementImplCopyWith<$Res> {
  __$$TaskElementImplCopyWithImpl(
      _$TaskElementImpl _value, $Res Function(_$TaskElementImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskElement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? priorityId = null,
    Object? statusId = null,
    Object? categoryId = null,
    Object? recurrence = null,
    Object? estimatedTime = null,
    Object? comments = freezed,
    Object? attachments = freezed,
    Object? geoLocation = null,
    Object? parentId = freezed,
    Object? children = null,
  }) {
    return _then(_$TaskElementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      priorityId: null == priorityId
          ? _value.priorityId
          : priorityId // ignore: cast_nullable_to_non_nullable
              as int,
      statusId: null == statusId
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as String?,
      geoLocation: null == geoLocation
          ? _value.geoLocation
          : geoLocation // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TaskElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskElementImpl implements _TaskElement {
  const _$TaskElementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.priorityId,
      required this.statusId,
      required this.categoryId,
      required this.recurrence,
      required this.estimatedTime,
      required this.comments,
      required this.attachments,
      required this.geoLocation,
      required this.parentId,
      required final List<TaskElement> children})
      : _children = children;

  factory _$TaskElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskElementImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final int priorityId;
  @override
  final int statusId;
  @override
  final int categoryId;
  @override
  final String recurrence;
  @override
  final int estimatedTime;
  @override
  final String? comments;
  @override
  final String? attachments;
  @override
  final String geoLocation;
  @override
  final int? parentId;
// Puede ser nulo si es la tarea principal
  final List<TaskElement> _children;
// Puede ser nulo si es la tarea principal
  @override
  List<TaskElement> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'TaskElement(id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, priorityId: $priorityId, statusId: $statusId, categoryId: $categoryId, recurrence: $recurrence, estimatedTime: $estimatedTime, comments: $comments, attachments: $attachments, geoLocation: $geoLocation, parentId: $parentId, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskElementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.priorityId, priorityId) ||
                other.priorityId == priorityId) &&
            (identical(other.statusId, statusId) ||
                other.statusId == statusId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.attachments, attachments) ||
                other.attachments == attachments) &&
            (identical(other.geoLocation, geoLocation) ||
                other.geoLocation == geoLocation) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      startDate,
      endDate,
      priorityId,
      statusId,
      categoryId,
      recurrence,
      estimatedTime,
      comments,
      attachments,
      geoLocation,
      parentId,
      const DeepCollectionEquality().hash(_children));

  /// Create a copy of TaskElement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskElementImplCopyWith<_$TaskElementImpl> get copyWith =>
      __$$TaskElementImplCopyWithImpl<_$TaskElementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskElementImplToJson(
      this,
    );
  }
}

abstract class _TaskElement implements TaskElement {
  const factory _TaskElement(
      {required final int id,
      required final String title,
      required final String description,
      required final String startDate,
      required final String endDate,
      required final int priorityId,
      required final int statusId,
      required final int categoryId,
      required final String recurrence,
      required final int estimatedTime,
      required final String? comments,
      required final String? attachments,
      required final String geoLocation,
      required final int? parentId,
      required final List<TaskElement> children}) = _$TaskElementImpl;

  factory _TaskElement.fromJson(Map<String, dynamic> json) =
      _$TaskElementImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  int get priorityId;
  @override
  int get statusId;
  @override
  int get categoryId;
  @override
  String get recurrence;
  @override
  int get estimatedTime;
  @override
  String? get comments;
  @override
  String? get attachments;
  @override
  String get geoLocation;
  @override
  int? get parentId; // Puede ser nulo si es la tarea principal
  @override
  List<TaskElement> get children;

  /// Create a copy of TaskElement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskElementImplCopyWith<_$TaskElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
