import 'package:abctechapp/src/modules/login/dto/signup_request_dto.dart';
import 'package:abctechapp/src/modules/login/service/auth_service.dart';
import 'package:abctechapp/src/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController with StateMixin<SignupRequestDTO> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService;

  SignupController(this._authService);

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  validateUsernameInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite o nome do usuário.';
    }

    if (value.length < 5 || value.length > 50) {
      return 'Deve ter entre 5 e 50 caracteres.';
    }

    return null;
  }

  validateEmailInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite o e-mail.';
    }

    if (!GetUtils.isEmail(value)) {
      return 'Digite um e-mail válido';
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
    emailController.text = "";
    passwordController.text = "";
  }

  formSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        final signupRequestDTO = SignupRequestDTO(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        await _authService.signup(signupRequestDTO).then((value) => {
              clearForm(),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastrado com sucesso, realize o login para começar.')),
              ),
              Get.toNamed(Routes.home)
            });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
