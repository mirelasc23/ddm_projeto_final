import 'package:ddm_projeto_final/view/tela_lista.dart';
import 'package:ddm_projeto_final/view/tela_lista_v01.dart';
import 'package:ddm_projeto_final/view/tela_perfil.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget{
  final int paginaSelecionada;

  final List<Widget> _telas = [
    TelaLista_v01(titulo: 'TelaLista_v01',),
    TelaLista(titulo: 'TelaLista'),
    TelaPerfil(),
  ];

  final Function(int) aoSelecionarPagina;

  Navbar({super.key, required this.paginaSelecionada, required this.aoSelecionarPagina});
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: paginaSelecionada,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      onTap: aoSelecionarPagina,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: 'Mapa',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Perfil',
          ),
      ],
      /*currentIndex: _indiceAtual,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, */
    );
  }

  
}