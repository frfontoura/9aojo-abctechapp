import 'package:abctechapp/src/modules/login/controller/signin_controller.dart';
import 'package:abctechapp/src/modules/login/provider/auth_provider.dart';
import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:get/get.dart';

class SigninPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>((() => SigninController(AuthService(AuthProvider()))));
  }
}
