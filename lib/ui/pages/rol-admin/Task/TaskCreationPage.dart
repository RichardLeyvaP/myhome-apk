import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhome/ui/pages/rol-admin/Task/additionalDataPage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/dateTimePage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/familySelecctionPage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/priorityPage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/recurrencePage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/startTaskPage.dart';
import 'package:myhome/ui/pages/rol-admin/Task/statusPage.dart';

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
          //1 Página
          StartTaskPage(pageController: _pageController),
          //2 Página
          PriorityPage(pageController: _pageController),
          //3 Página
          FamilySelectionPage(pageController: _pageController),
          //4 Página
          StatusPage(pageController: _pageController),
          //6 Página
          RecurrencePage(pageController: _pageController),
          //7 Página
          AdditionalDataPage(pageController: _pageController),
          //7 Página
          DateTimePage(pageController: _pageController),
        ],
      ),
    );
  }
}
