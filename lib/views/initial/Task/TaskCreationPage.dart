import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/views/initial/Task/familySelecctionPage.dart';
import 'package:myhome/views/initial/Task/priorityPage.dart';
import 'package:myhome/views/initial/Task/startTaskPage.dart';

class TaskCreation extends StatefulWidget {
  @override
  _TaskCreationState createState() => _TaskCreationState();
}

class _TaskCreationState extends State<TaskCreation> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        children: [
          //Primer Página
          StartTaskPage(pageController: _pageController),
          //segunda Página
          PriorityPage(pageController: _pageController),
          //Tercera Página
          FamilySelectionPage(pageController: _pageController),
        ],
      ),
    );
  }
}
