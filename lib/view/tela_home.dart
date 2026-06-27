import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/paginainicial-fundo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 600, bottom: 100, left: 20, right: 180),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            // foregroundColor: Colors.green.withOpacity(0.2),
            backgroundBuilder:
                (BuildContext context, Set<WidgetState> states, Widget? child) {
                  return Ink(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/imagem_plantar.png'),
                        fit: .fitWidth,
                      ),
                    ),
                    child: child,
                  );
                },
          ),
          child: const Text(''),
        ),
      ),
    );
  }
}
