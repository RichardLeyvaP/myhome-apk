// Modelo de categoría
import 'package:flutter/material.dart';

class Category {
  final String title;
  final IconData icon;
  final int id;

  Category({required this.title, required this.icon, required this.id});
}

class Status {
  final String title;
  final IconData icon;
  final int id;

  Status({required this.title, required this.icon, required this.id});
}

class Priority {
  final String title;
  final String description;
  final int id;

  Priority({required this.title, required this.description, required this.id});
}

class Taskperson {
  final int id;
  final String namePerson;
  final String imagePerson;
  final dynamic rolId;
  final String nameRole;

  Taskperson(
      {required this.id,
      required this.namePerson,
      required this.imagePerson,
      required this.rolId,
      required this.nameRole});
}
