import 'package:get/get.dart';
import 'package:myhome/Routes/index.dart';

class DependencyInjection {
  static void registerDependencies() {
    Get.put(LoginController());

    // Agrega más controladores según sea necesario
  }
}
