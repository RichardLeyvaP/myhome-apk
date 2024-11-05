import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class NavigationInitial extends NavigationState {}

class ScreenChanged extends NavigationState {
  final String screenName;
  final DateTime timestamp;

  const ScreenChanged(this.screenName, this.timestamp);

  @override
  List<Object?> get props => [screenName, timestamp];
}

class ActionPerformed extends NavigationState {
  final String actionDescription;
  final String? selectedItemTitle;
  final DateTime timestamp;

  const ActionPerformed(this.actionDescription, {this.selectedItemTitle, required this.timestamp});

  @override
  List<Object?> get props => [actionDescription, selectedItemTitle, timestamp];
}

class DataInput extends NavigationState {
  final String field;
  final String inputType;
  final dynamic value;
  final DateTime timestamp;

  const DataInput(this.field, this.inputType, this.value, this.timestamp);

  @override
  List<Object?> get props => [field, inputType, value, timestamp];
}

class ErrorEncountered extends NavigationState {
  final String errorDescription;
  final String context;
  final DateTime timestamp;

  const ErrorEncountered(this.errorDescription, this.context, this.timestamp);

  @override
  List<Object?> get props => [errorDescription, context, timestamp];
}

class SessionStatus extends NavigationState {
  final DateTime sessionStart;
  final DateTime? sessionEnd;
  final Duration? duration;

  const SessionStatus(this.sessionStart, {this.sessionEnd, this.duration});

  @override
  List<Object?> get props => [sessionStart, sessionEnd, duration];
}
