import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/widgets/botao_acao.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Container(
      width: tamanhoTela.width,
      height: tamanhoTela.height,

      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/paginainicial-fundo.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: tamanhoTela.height * 0.42,
              right: 30,
              child: BotaoAcao(
                imagem: 'assets/images/regar.png',
                label: 'Regar',
                cor: Colors.lightBlue,
                tamanho: 220,
                onTap: () {
                  //implementar
                },
              ),
            ),
            Positioned(
              top: tamanhoTela.height * 0.62,
              left: 30,
              child: BotaoAcao(
                imagem: 'assets/images/plantar.png',
                label: 'Plantar',
                cor: Colors.lightGreen,
                onTap: () {
                  //implementar
                },
              ),
            ),
          ],
        ),
        // padding: const EdgeInsets.only(
        //   top: 600,
        //   bottom: 100,
        //   left: 20,
        //   right: 180,
        // ),
        // child: TextButton(
        //   onPressed: () {},
        //   style: TextButton.styleFrom(
        //     backgroundBuilder:
        //         (BuildContext context, Set<WidgetState> states, Widget? child) {
        //           return Ink(
        //             decoration: const BoxDecoration(
        //               image: DecorationImage(
        //                 image: AssetImage('assets/images/plantar.png'),
        //                 fit: BoxFit.fitWidth,
        //               ),
        //             ),
        //             child: child,
        //           );
        //         },
        //   ),
        //   child: const Text(''),
      ),
    );
  }
}
