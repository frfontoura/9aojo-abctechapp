import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isLogged.value ? null : const RouteSettings(name: Routes.home);
  }
}
