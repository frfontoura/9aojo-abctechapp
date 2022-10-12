import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  _validateUsernameInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite o nome do usuário';
    }
    return null;
  }

  _formSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Icons.engineering,
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
                    padding: const EdgeInsets.all(40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(label: Text('Usuário')),
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
                              onPressed: () => _formSubmit(),
                              child: const Text('Entrar'),
                            ),
                          )
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
