import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/provider/rega_provider.dart';
import 'package:ddm_projeto_final/service/localizacao_page.dart';
import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/widgets/botao_acao.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ddm_projeto_final/util/fontes.dart';

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
              top: tamanhoTela.height * 0.1,
              left: 0,
              right: 0,
              child: Center(
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
            ),
            Positioned(
              top: tamanhoTela.height * 0.4,
              right: 30,
              child: BotaoAcao(
                imagem: 'assets/images/regar.png',
                label: 'Regar',
                cor: Colors.lightBlue,
                tamanho: 220,
                onTap: () {
                  final provider = Provider.of<RegaProvider>(
                    context,
                    listen: false,
                  );
                  final hoje = DateTime.now();
                  final dataHoje =
                      '${hoje.year}-${hoje.month.toString().padLeft(2, '0')}-${hoje.day.toString().padLeft(2, '0')}';
                  final rega = Rega(idPlanta: 1, dataRega: dataHoje);
                  provider.regar(rega);
                  /*final planta = Planta(nome: 'tst', lat: 1.0, long: 1.0);
                  Provider.of<PlantaProvider>(
                    context,
                    listen: false,
                  ).regarPlanta(context, planta);*/
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
                onTap: () async {
                  final controller = TextEditingController();
                  final nome = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Nova planta'),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(hintText: 'Nome da planta'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, controller.text),
                          child: Text('Salvar'),
                        ),
                      ],
                    ),
                  );
                  if (nome != null && nome.isNotEmpty) {
                    final provider = Provider.of<PlantaProvider>(
                      context,
                      listen: false,
                    );

                    LocalizacaoPage localizacaoPlanta = LocalizacaoPage();
                    await localizacaoPlanta.pegarLocalizacao();
                    Position? posicaoPlanta = localizacaoPlanta.posicao;

                    if (posicaoPlanta != null) {
                      // Arredonda para 5 casas decimais (~1 metro de precisão)
                      double latArredondada = double.parse(
                        posicaoPlanta.latitude.toStringAsFixed(5),
                      );
                      double longArredondada = double.parse(
                        posicaoPlanta.longitude.toStringAsFixed(5),
                      );

                      Planta planta = Planta(
                        nome: nome,
                        lat: latArredondada,
                        long: longArredondada,
                      );

                      await provider.adicionarPlanta(planta);
                      print("Planta salva com sucesso: $planta");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Não foi possível obter a localização atual.',
                          ),
                        ),
                      );
                      print('Não foi possível obter a localização atual.');
                    }
                  }
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
