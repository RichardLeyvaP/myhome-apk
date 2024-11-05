import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/domain/blocs/user_activity_bloc/user_activity_event.dart';
import 'package:myhome/domain/blocs/user_activity_bloc/user_activity_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<ScreenChangeEvent>(_onScreenChange);
    on<ActionPerformedEvent>(_onActionPerformed);
    on<DataInputEvent>(_onDataInput);
    on<ErrorEncounteredEvent>(_onErrorEncountered);
    on<SessionStartedEvent>(_onSessionStarted);
    on<SessionEndedEvent>(_onSessionEnded);
  }

  // Maneja el cambio de pantalla
  void _onScreenChange(ScreenChangeEvent event, Emitter<NavigationState> emit) {
    emit(ScreenChanged(event.screenName, event.timestamp));
  }

  // Maneja las acciones realizadas por el usuario
  void _onActionPerformed(ActionPerformedEvent event, Emitter<NavigationState> emit) {
    emit(ActionPerformed(event.actionDescription,
        selectedItemTitle: event.selectedItemTitle, timestamp: event.timestamp));
  }

  // Maneja la entrada de datos por el usuario
  void _onDataInput(DataInputEvent event, Emitter<NavigationState> emit) {
    emit(DataInput(event.field, event.inputType, event.value, event.timestamp));
  }

  // Maneja errores encontrados en la navegación
  void _onErrorEncountered(ErrorEncounteredEvent event, Emitter<NavigationState> emit) {
    emit(ErrorEncountered(event.errorDescription, event.context, event.timestamp));
  }

  // Maneja el inicio de sesión
  void _onSessionStarted(SessionStartedEvent event, Emitter<NavigationState> emit) {
    emit(SessionStatus(event.sessionStart));
  }

  // Maneja el final de sesión y calcula la duración
  void _onSessionEnded(SessionEndedEvent event, Emitter<NavigationState> emit) {
    final currentState = state;
    if (currentState is SessionStatus) {
      final duration = event.sessionEnd.difference(currentState.sessionStart);
      emit(SessionStatus(currentState.sessionStart, sessionEnd: event.sessionEnd, duration: duration));
    }
  }
}
