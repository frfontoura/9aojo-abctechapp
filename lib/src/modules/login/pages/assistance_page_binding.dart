import 'package:abctechapp/src/modules/login/controller/assistance_controller.dart';
import 'package:abctechapp/src/modules/login/provider/assistance_provider.dart';
import 'package:get/get.dart';

class AssistancePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AssistanceController>(AssistanceController());
  }
}
