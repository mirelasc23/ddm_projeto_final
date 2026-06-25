import 'package:ddm_projeto_final/util/fontes.dart';
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
                        Text(
                          "Cresce, Brotinho!",
                          style: TextStyle(
                            fontFamily: AppFonts.railey,
                            fontSize: 55,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.blue,
                          ),
                        ),
                        const Text(
                          "Cresce, Brotinho!",
                          style: TextStyle(
                            fontFamily: AppFonts.railey,
                            fontSize: 54,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: [
                              // Primeira camada projetada (mais próxima)
                              /*Shadow(
                                blurRadius: 0.0,
                                color: Color.from(
                                  alpha: 0.5,
                                  red: 0.13,
                                  green: 0.59,
                                  blue: 0.95,
                                ), // Cor do eco do Canva
                                offset: Offset(4.0, 4.0), // Multiplicador 1
                              ),
                              // Segunda camada projetada
                              Shadow(
                                blurRadius: 0.0,
                                color: Color.from(
                                  alpha: 0.3,
                                  red: 0.13,
                                  green: 0.59,
                                  blue: 0.95,
                                ),
                                offset: Offset(4.0, 4.0), // Multiplicador 2
                              ),*/
                              // Terceira camada projetada (mais distante)
                              Shadow(
                                blurRadius: 0.0,
                                color: Color.from(
                                  alpha: 0.1,
                                  red: 0.13,
                                  green: 0.59,
                                  blue: 0.95,
                                ),
                                offset: Offset(4.0, 4.0), // Multiplicador 3
                              ),
                            ],
                          ),
                        ),
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
