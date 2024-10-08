import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/configuration/configuration_model.dart';

abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent();

  @override
  List<Object?> get props => [];
}

class ConfigurationRequested extends ConfigurationEvent {
  final DateTime requestTime;

  const ConfigurationRequested(this.requestTime);

  @override
  List<Object?> get props => [requestTime];
}

class ConfigurationUpdated extends ConfigurationEvent {
  final Configuration configurationElement;

  const ConfigurationUpdated(this.configurationElement);

  @override
  List<Object?> get props => [configurationElement];
}

class ConfigurationLanguageUpdated extends ConfigurationEvent {
  final String language;

  const ConfigurationLanguageUpdated(this.language);

  @override
  List<Object?> get props => [language];
}

class ConfigurationSubmitted extends ConfigurationEvent {}

class IncreaseFontSize extends ConfigurationEvent {}
