import 'package:abctechapp/src/modules/login/pages/login_page.dart';
import 'package:abctechapp/src/modules/login/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AbcTechApp',
      theme: ThemeData(
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
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
  }
}
