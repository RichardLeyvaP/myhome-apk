import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhome/data/models/configuration/configuration_model.dart';
import 'package:myhome/data/repository/configuration_repository.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_event.dart';
import 'package:myhome/domain/blocs/configuration_bloc/configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final ConfigurationRepository configurationRepository;

  // Estado actual de la configuración
  // Mantiene el estado de la configuración actual
  Configuration? _configurationElement;
  int fontSize = 14; // Ejemplo de una configuración, como tamaño de letra

  ConfigurationBloc({required this.configurationRepository}) : super(ConfigurationInitial()) {
    on<ConfigurationRequested>(_onConfigurationRequested);
    on<ConfigurationUpdated>(_onConfigurationUpdated);
    on<ConfigurationSubmitted>(_onConfigurationSubmitted);
    on<IncreaseFontSize>((event, emit) {
      emit(FontSizeUpdated(fontSize += 1));
    });
  }

  // Manejar solicitud de configuración
  Future<void> _onConfigurationRequested(ConfigurationRequested event, Emitter<ConfigurationState> emit) async {
    emit(ConfigurationLoading());
    try {
      final result = await configurationRepository.getConfigurations(); // Obtener configuración desde el repositorio
      print('Obteniendo configuraciones-resultado probando*************-222');
      print('Obteniendo configuraciones-resultado probando*************-33result:${result.runtimeType}');

      if (result is String) {
        print('Obteniendo configuraciones-resultado ConfigurationFailure');
        emit(ConfigurationFailure(result));
      } else if (result is Configuration) {
        print('Obteniendo configuraciones-resultado ConfigurationSuccess');

        // Aquí inicializamos _configurationElement
        _configurationElement = result;

        emit(ConfigurationSuccess(result));
      }
    } catch (error) {
      print('Obteniendo configuraciones-resultado catch-ConfigurationFailure');
      emit(ConfigurationFailure(error.toString()));
    }
  }

  // Manejar actualización de la configuración
  void _onConfigurationUpdated(ConfigurationUpdated event, Emitter<ConfigurationState> emit) {
    if (_configurationElement != null) {
      _configurationElement = _configurationElement!.copyWith(
        language: event.configurationElement.language ?? _configurationElement!.language,
        themeColor: event.configurationElement.themeColor ?? _configurationElement!.themeColor,
        appName: event.configurationElement.appName ?? _configurationElement!.appName,
      );

      emit(ConfigurationSubmittedUpdated(_configurationElement!));
    } else {
      // Manejo si _configurationElement es null, puedes emitir un estado de error o inicializarlo
      emit(ConfigurationFailure("Configuración no inicializada."));
    }
  }

  // Manejar envío de la configuración a la API
  Future<void> _onConfigurationSubmitted(ConfigurationSubmitted event, Emitter<ConfigurationState> emit) async {
    // emit(ConfigurationLoading());
    print('_onConfigurationSubmitted entrando y con idioma:${_configurationElement!.language}');
    try {
      await configurationRepository.updateConfiguration(_configurationElement!); // Enviar la configuración a la API
      print('_onConfigurationSubmitted despues del metodo');
      emit(ConfigurationSubmittedUpdated(_configurationElement!));
    } catch (error) {
      //  emit(ConfigurationSubmittedFailure(error: error.toString()));
    }
  }
}
