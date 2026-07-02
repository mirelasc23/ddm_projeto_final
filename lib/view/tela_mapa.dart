import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/regiao.dart';
import 'package:ddm_projeto_final/util/dbhelper.dart';

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
    _carregarMapa();
  }

  Future<void> _carregarMapa() async {
    final plantas = await DatabaseHelper.instance.buscarPlantas();
    print("Plantas qtd: ${plantas.length}");
    setState(() {
      _plantas = plantas;
      _regiao = Regiao.calcularDePlantas(plantas);
      _carregando = false;
    });
  }

  void _abrirCardPlanta(Planta planta) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(planta.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              // TODO: imagem, histórico de rega, botão "Regar agora"
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
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
          children: _plantas.map((planta) {
            final posicao = regiao.coordenadaParaPosicao(planta.lat, planta.long);
            return Positioned(
              left: tamanhoTela.width * posicao.dx,
              top: tamanhoTela.height * posicao.dy,
              child: GestureDetector(
                onTap: () => _abrirCardPlanta(planta),
                child: const Icon(Icons.location_on, color: Colors.red, size: 42),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}