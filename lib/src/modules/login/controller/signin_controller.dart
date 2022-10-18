import 'package:abctechapp/src/modules/login/dto/signin_request_dto.dart';
import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController with StateMixin<String> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService;

  SigninController(this._authService);

  validateUsernameInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite o nome do usuário.';
    }

    if (value.length < 5 || value.length > 50) {
      return 'Deve ter entre 5 e 50 caracteres.';
    }

    return null;
  }

  validatePasswordInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite a senha.';
    }

    if (value.length < 8 || value.length > 50) {
      return 'Deve ter entre 8 e 50 caracteres.';
    }

    return null;
  }

  void clearForm() {
    usernameController.text = "";
    passwordController.text = "";
  }

  formSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        final signinRequestDTO = SigninRequestDTO(
          username: usernameController.text,
          password: passwordController.text,
        );

        await _authService.signin(signinRequestDTO).then((value) => {clearForm(), Get.offAndToNamed(Routes.orders)});
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
