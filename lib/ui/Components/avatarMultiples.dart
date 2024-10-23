import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:myhome/data/models/tasks/tasks_model.dart';

class AvatarMultiple extends StatelessWidget {
  final List<Person> people; // Añadir la lista de personas al widget

  const AvatarMultiple({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedPositions(
      maxCoverage: 0.3,
      minCoverage: 0.6,
      align: StackAlign.right,
    );

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: AvatarStack(
        height: 40,
        settings: settings,
        borderWidth: 0.8,
        avatars: people.map((person) => NetworkImage(person.image)).toList(),
      ),
    );
  }
}

String getAvatarUrl(int n) {
  final url = 'https://i.pravatar.cc/150?img=$n';
  // final url = 'https://robohash.org/$n?bgset=bg1';
  return url;
}
