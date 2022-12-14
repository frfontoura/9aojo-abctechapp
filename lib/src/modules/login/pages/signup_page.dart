import 'package:abctechapp/src/modules/login/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignupController> {
  const SignUpPage({super.key});

  Widget buildForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: controller.usernameController,
            decoration: const InputDecoration(label: Text('Usuário')),
            validator: (value) => controller.validateUsernameInput(value),
          ),
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(label: Text('E-mail')),
            validator: (value) => controller.validateEmailInput(value),
          ),
          TextFormField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(label: Text('Senha')),
            validator: (value) => controller.validatePasswordInput(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => controller.formSubmit(context),
              child: const Text('Cadastrar'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Icon(
                    Icons.account_box,
                    color: Colors.orange,
                    size: 240,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: controller.obx((state) => buildForm(context)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
