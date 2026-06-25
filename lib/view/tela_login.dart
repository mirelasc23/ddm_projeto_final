import 'package:ddm_projeto_final/widgets/form_login.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: tamanhoTela.width,
        height: tamanhoTela.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-fundo.png'), // Imagem Local
            // image: NetworkImage('https://link-da-sua-imagem.com'), // Imagem da Internet
            fit: BoxFit.cover, // Garante que a imagem cubra toda a tela
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 40),
                  child: const Text(
                    "Cresce, Brotinho",
                    style: TextStyle(fontSize: 26, color: Colors.brown),
                  ),
                ),
                const FormLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
