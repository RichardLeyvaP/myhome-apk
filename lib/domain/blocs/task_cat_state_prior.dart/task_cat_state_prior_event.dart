import 'package:equatable/equatable.dart';

// Definimos la clase abstracta que otros eventos heredan
abstract class CategoriesPrioritiesEvent extends Equatable {
  const CategoriesPrioritiesEvent();

  @override
  List<Object?> get props => [];
}

// Evento para solicitar las categorías y prioridades
class CategoriesRequested extends CategoriesPrioritiesEvent {}
