import 'package:equatable/equatable.dart';
import 'package:myhome/data/models/configuration/configuration_model.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  List<Object?> get props => [];
}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoading extends ConfigurationState {}

class ConfigurationSuccess extends ConfigurationState {
  final Configuration configuration;

  const ConfigurationSuccess(this.configuration);

  @override
  List<Object?> get props => [configuration];
}

class ConfigurationFailure extends ConfigurationState {
  final String error;

  const ConfigurationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ConfigurationSubmittedSuccess extends ConfigurationState {}

class ConfigurationSubmitting extends ConfigurationState {}

class ConfigurationSubmittedFailure extends ConfigurationState {
  final String error;

  const ConfigurationSubmittedFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ConfigurationSubmittedUpdated extends ConfigurationState {
  final Configuration configurationElement;

  const ConfigurationSubmittedUpdated(this.configurationElement);

  @override
  List<Object?> get props => [configurationElement];
}

class FontSizeUpdated extends ConfigurationState {
  final int fontSize;

  const FontSizeUpdated(this.fontSize);

  @override
  List<Object?> get props => [fontSize];
}
