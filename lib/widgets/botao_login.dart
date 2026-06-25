import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:flutter/material.dart';

class BotaoLogin extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final bool estiloPrimario;

  const BotaoLogin({
    super.key,
    required this.texto,
    required this.onPressed,
    required this.estiloPrimario,
  });

  TextStyle? formatarBotao() {
    if (estiloPrimario) {
      return TextStyle(
        color: Colors.white,
        fontFamily: AppFonts.childos,
        fontSize: 24,
      );
    } else {
      return TextStyle(
        //color: Colors.white,
        fontFamily: AppFonts.childos,
        fontSize: 18,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        backgroundColor: estiloPrimario
            ? const Color.fromRGBO(255, 204, 0, 1)
            : Colors.grey[200],
      ),
      child: Text(texto, style: formatarBotao()),
    );
  }
}
