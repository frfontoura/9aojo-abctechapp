import 'package:abctechapp/src/modules/login/controller/signup_controller.dart';
import 'package:abctechapp/src/modules/login/provider/auth_provider.dart';
import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:get/get.dart';

class SignupPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>((() => SignupController(AuthService(AuthProvider()))));
  }
}
