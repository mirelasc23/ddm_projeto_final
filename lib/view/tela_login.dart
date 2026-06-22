import 'package:ddm_projeto_final/widgets/form_login.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 40),
                child: const Text(
                  "Bem-vindo",
                  style: TextStyle(fontSize: 26, color: Colors.brown),
                ),
              ),
              const FormLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
