import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpPage({super.key});

  _validateUsernameInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite o nome do usuário';
    }
    return null;
  }

  _formSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastrado com sucesso, realize o login para começar.')),
      );
      Get.back();
    }
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(label: Text('Usuário')),
                            validator: (value) => _validateUsernameInput(value),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(label: Text('E-mail')),
                            validator: (value) => _validateUsernameInput(value),
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(label: Text('Senha')),
                            validator: (value) => _validateUsernameInput(value),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () => _formSubmit(context),
                              child: const Text('Cadastrar'),
                            ),
                          ),
                        ],
                      ),
                    ),
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
