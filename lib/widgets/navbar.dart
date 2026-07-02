import 'package:flutter/material.dart';

class Navbar extends StatelessWidget{
  final int paginaSelecionada;
  final ValueChanged<int> onTap;

  const Navbar({
    Key? key,
    required this.paginaSelecionada,
    required this.onTap,
  }) : super(key: key);

  static const _icones = [
    Icons.home,
    Icons.location_on,
    Icons.person
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.lightGreen.withOpacity(0.35),
        borderRadius: BorderRadius.circular(40)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icones.length, (index){
          final selecionada = paginaSelecionada == index;
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selecionada ? Colors.lightGreen : Colors.transparent
              ),
              child: Icon(
              _icones[index],
              color: selecionada ? Colors.white : Colors.black87,
              size: 26,
              ),
            ),
          );
        },
        ),
      ),
    );
  }
}