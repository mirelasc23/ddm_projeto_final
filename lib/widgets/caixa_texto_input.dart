import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/util.dart';
import 'package:flutter/material.dart';

Widget caixaTextoExibicaoInput(String label, String valor) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            letterSpacing: 0.4,
            color: Color.fromARGB(188, 158, 158, 158),
            fontFamily: AppFonts.mairy,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.53),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(valor, style: Util.estiloTextoInterno()),
      ),
    ],
  );
}
