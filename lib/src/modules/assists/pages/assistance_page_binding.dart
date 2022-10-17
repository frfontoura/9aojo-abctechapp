import 'package:abctechapp/src/modules/assists/controller/assistance_controller.dart';
import 'package:get/get.dart';

class AssistancePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AssistanceController>(AssistanceController());
  }
}
