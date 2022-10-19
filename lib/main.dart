import 'package:abctechapp/src/infraestructure/api.dart';
import 'package:abctechapp/src/modules/assists/provider/assistance_provider.dart';
import 'package:abctechapp/src/modules/login/provider/auth_provider.dart';
import 'package:abctechapp/src/modules/assists/service/assistance_service.dart';
import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:abctechapp/src/modules/order/provider/order_provider.dart';
import 'package:abctechapp/src/modules/order/service/geolocation_service.dart';
import 'package:abctechapp/src/modules/order/service/order_service.dart';
import 'package:abctechapp/src/navigation/pages.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

Future<void> initApp() async {
  await GetStorage.init();

  Get.put(Api());
  Get.put(AssistanceService(AssistanceProvider()));
  Get.put(OrderService(OrderProvider()));
  Get.put(GeolocationService());

  final AuthService authService = Get.put(AuthService(AuthProvider()));

  authService.checkLoginStatus();

  return Future.sync(() => null);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData theme() {
    return ThemeData(
      primarySwatch: Colors.orange,
      hintColor: Colors.orange,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        errorStyle: TextStyle(fontSize: 18, color: Colors.deepOrange),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(fontSize: 18, color: Colors.orange),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AbcTechApp',
      theme: theme(),
      initialRoute: Routes.home,
      getPages: appPages,
    );
  }
}
