import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/planta_card.dart';
import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/regiao.dart';
import 'package:provider/provider.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({Key? key}) : super(key: key);

  @override
  State<TelaMapa> createState() => _TelaMapaState();
}

class _TelaMapaState extends State<TelaMapa> {
  List<Planta> _plantas = [];
  Regiao? _regiao;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarMapa();
    });
  }

  Future<void> _carregarMapa() async {
    final provider = Provider.of<PlantaProvider>(context, listen: false);
    await provider.carregarPlantas;
    print("Plantas qtd: ${provider.plantas.length}");

    setState(() {
      _plantas = provider.plantas;
      if (_plantas.isNotEmpty) {
        _regiao = Regiao.calcularDePlantas(provider.plantas);
      }
      _carregando = false;
    });
  }

  void _abrirCardPlanta(BuildContext context, Planta planta) {
    PlantaCardSheet.mostrar(context, planta);
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    final plantasDoProvider = Provider.of<PlantaProvider>(context).plantas;

    if (plantasDoProvider.length != _plantas.length) {
      _plantas = plantasDoProvider;
      if (_plantas.isNotEmpty) {
        _regiao = Regiao.calcularDePlantas(_plantas);
      }
    }

    if (_plantas.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Você ainda não plantou nada.\nUse o botão "Plantar" na Home!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final tamanhoTela = MediaQuery.of(context).size;
    final regiao = _regiao!;
    return Container(
      width: tamanhoTela.width,
      height: tamanhoTela.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/mapa-fundo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            ..._plantas.map((planta) {
              final posicao = regiao.coordenadaParaPosicao(
                planta.lat,
                planta.long,
              );
              return Positioned(
                left: tamanhoTela.width * posicao.dx,
                top: tamanhoTela.height * posicao.dy,
                child: GestureDetector(
                  onTap: () => _abrirCardPlanta(context, planta),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 42,
                  ),
                ),
              );
            }).toList(),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  // Ação do seu botão aqui (ex: voltar para home, centralizar mapa, etc)
                  print("Botão do mapa pressionado!");
                  Navigator.pushNamed(context, Rotas.telaLista);
                },
                child: const Icon(Icons.list, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
