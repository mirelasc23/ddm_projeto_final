import 'package:ddm_projeto_final/service/mapa_page_oirginal.dart';
import 'package:ddm_projeto_final/view/tela_perfil.dart';
import 'package:ddm_projeto_final/view/tela_home.dart';
import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/widgets/navbar.dart';

class Telas extends StatefulWidget {
  const Telas({super.key});

  @override
  State<Telas> createState() => _TelasState();
}

class _TelasState extends State<Telas> {
  int _selectedIndex = 0;

  void _navegarNavbar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _paginas = [TelaHome(), MapaPage(), TelaPerfil()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      body: _paginas[_selectedIndex],
      bottomNavigationBar: Navbar(
        paginaSelecionada: _selectedIndex,
        onTap: _navegarNavbar,
      ),
    );
  }
}
