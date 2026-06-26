import 'package:ddm_projeto_final/provider/usuario_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLista extends StatelessWidget {
  final String titulo;

  const TelaLista({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      body: Container(
        width: tamanhoTela.width,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/paginainicial-fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // InkWell(
                //   onTap: () {},
                //   child: Ink.image(
                //     image: AssetImage('assets/images/imagem_plantar.png'),
                //     fit: BoxFit.cover,
                //     width: 100,
                //     height: 100,
                //   ),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, Rotas.telaPerfil);
                  },
                  icon: Image.asset('assets/images/imagem_plantar.png', width: 24, height: 24),
                  label: Text('Clique Aqui'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
