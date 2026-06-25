import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/widgets/form_login.dart';
import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: tamanhoTela.width,
        height: tamanhoTela.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tela-perfil.png'), // Imagem Local
            // image: NetworkImage('https://link-da-sua-imagem.com'), // Imagem da Internet
            fit: BoxFit.cover, // Garante que a imagem cubra toda a tela
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 40),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 6.0,
                      bottom: 16.0,
                    ), // Espaço para o deslocamento X e Y
                    //padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        
                      ],
                    ),
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
