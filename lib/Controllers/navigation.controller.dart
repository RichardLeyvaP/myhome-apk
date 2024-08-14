// ignore_for_file: depend_on_referenced_packages

import 'package:myhome/get_connect/repository/user.repository.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  UserRepository usuarioLg = UserRepository();

  int selectMenu = 0;
  void setSelectMenu(int value) {
    selectMenu = value;
    update();
  }

  int getSelectMenu() {
    return selectMenu;
  }

  //
}
