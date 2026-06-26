import 'package:ddm_projeto_final/view/tela_lista.dart';
import 'package:ddm_projeto_final/view/tela_lista_v01.dart';
import 'package:ddm_projeto_final/view/tela_perfil.dart';
import 'package:flutter/material.dart';

class NavbarApp extends StatelessWidget {
  const NavbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Navbar());
  }
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  // final List<Widget> _telas = [
  //   TelaLista(titulo: 'Inicio'),
  //   Placeholder(),
  //   TelaPerfil(),
  // ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(


        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        
        backgroundColor: Colors.lightGreen.withOpacity(0.2),
        elevation: 0,

        indicatorColor: const Color.fromARGB(255, 117, 137, 94),
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.map)),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      );
  }
}
