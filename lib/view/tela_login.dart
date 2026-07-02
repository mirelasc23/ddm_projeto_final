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
            image: AssetImage('assets/images/login-fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //const SizedBox(height: 50),
                Container(
                  height: tamanhoTela.height * 0.1,
                  margin: const EdgeInsets.only(bottom: 20, top: 90),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, bottom: 16.0),
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
