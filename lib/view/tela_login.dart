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
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 40),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        "Cresce, Brotinho",
                        style: TextStyle(
                          fontFamily: 'MinhaFonte',
                          fontSize: 54,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.blue,
                        ),
                      ),
                      const Text(
                        "Cresce, Brotinho",
                        style: TextStyle(
                          fontFamily: 'MinhaFonte',
                          fontSize: 54,
                          fontWeight: FontWeight.w400,
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
                const FormLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
