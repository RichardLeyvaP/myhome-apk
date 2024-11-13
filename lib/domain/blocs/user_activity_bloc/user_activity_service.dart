import 'package:myhome/domain/blocs/user_activity_bloc/user_activity_signal.dart';

// Funciones para manejar las acciones y actualizar las señales
void onScreenChange(String screenName, DateTime timestamp) {
  currentScreen.value = screenName;
}

void onActionPerformed(String actionDesc, {String? itemTitle, required DateTime timestamp}) {
  actionDescription.value = actionDesc;
  selectedItemTitle.value = itemTitle;
}

void onDataInput(String field, String type, dynamic value, DateTime timestamp) {
  dataField.value = field;
  dataType.value = type;
  dataValue.value = value;
}

void onErrorEncountered(String errorDesc, String context, DateTime timestamp) {
  errorDescription.value = errorDesc;
  errorContext.value = context;
}

void onSessionStarted(DateTime start) {
  sessionStart.value = start;
  sessionEnd.value = null;
  sessionDuration.value = null;
}

void onSessionEnded(DateTime end) {
  if (sessionStart.value != null) {
    sessionEnd.value = end;
    sessionDuration.value = end.difference(sessionStart.value!);
  }
}
