import 'package:abctechapp/src/modules/login/pages/assistance_page.dart';
import 'package:abctechapp/src/modules/login/pages/assistance_page_binding.dart';
import 'package:abctechapp/src/modules/login/pages/signin_page.dart';
import 'package:abctechapp/src/modules/login/pages/signin_page_binding.dart';
import 'package:abctechapp/src/modules/login/pages/signup_page.dart';
import 'package:abctechapp/src/modules/login/pages/signup_page_binding.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:get/get.dart';

final appPages = [
  GetPage(name: Routes.home, page: () => const SigninPage(), binding: SigninPageBinding()),
  GetPage(name: Routes.signup, page: () => const SignUpPage(), binding: SignupPageBinding()),
  GetPage(name: Routes.assists, page: () => const AssistancePage(), binding: AssistancePageBinding())
];
