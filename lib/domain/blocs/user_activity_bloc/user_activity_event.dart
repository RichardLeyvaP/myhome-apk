import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class ScreenChangeEvent extends NavigationEvent {
  final String screenName;
  final DateTime timestamp;

  const ScreenChangeEvent(this.screenName, this.timestamp);

  @override
  List<Object?> get props => [screenName, timestamp];
}

class ActionPerformedEvent extends NavigationEvent {
  final String actionDescription;
  final String? selectedItemTitle;
  final DateTime timestamp;

  const ActionPerformedEvent(this.actionDescription, {this.selectedItemTitle, required this.timestamp});

  @override
  List<Object?> get props => [actionDescription, selectedItemTitle, timestamp];
}

class DataInputEvent extends NavigationEvent {
  final String field;
  final String inputType;
  final dynamic value;
  final DateTime timestamp;

  const DataInputEvent(this.field, this.inputType, this.value, this.timestamp);

  @override
  List<Object?> get props => [field, inputType, value, timestamp];
}

class ErrorEncounteredEvent extends NavigationEvent {
  final String errorDescription;
  final String context;
  final DateTime timestamp;

  const ErrorEncounteredEvent(this.errorDescription, this.context, this.timestamp);

  @override
  List<Object?> get props => [errorDescription, context, timestamp];
}

class SessionStartedEvent extends NavigationEvent {
  final DateTime sessionStart;

  const SessionStartedEvent(this.sessionStart);

  @override
  List<Object?> get props => [sessionStart];
}

class SessionEndedEvent extends NavigationEvent {
  final DateTime sessionEnd;

  const SessionEndedEvent(this.sessionEnd);

  @override
  List<Object?> get props => [sessionEnd];
}
