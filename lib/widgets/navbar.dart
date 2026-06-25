import 'package:flutter/material.dart';

class Navbar extends StatelessWidget{
  final int paginaSelecionada;

  final Function(int) aoSelecionarPagina;

  const Navbar({super.key, required this.paginaSelecionada, required this.aoSelecionarPagina});
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: paginaSelecionada,
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
    );
  }

  
}